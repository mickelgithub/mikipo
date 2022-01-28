import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/util/constants/string_constants.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/string_extensions.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/util/constants/notification_constants.dart';

class AuthRepositoryImpl implements IAuthRepository {
  static final _logger = getLogger((AuthRepositoryImpl).toString());

  static const String _EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const String _UNKNOWN_ERROR = 'unknown';
  static const String _UNABLE_RESOLVE_HOST = 'Unable to resolve host';
  static const String _TOO_MANY_REQUEST = 'too-many-requests';
  static const String _WRONG_PASSWORD = 'wrong-password';
  static const String _USER_NOT_FOUND = 'user-not-found';

  final IAuthRemoteDatasource _authRemoteDatasource;
  final IUserLocalDataSource _userLocalStorageDataSource;
  final IUserRemoteStorageDataSource _userRemoteStorageDataSource;
  final IAvatarRemoteDatasource _avatarRemoteDatasource;
  final IAvatarLocalDatasource _avatarLocalDatasource;
  final INotificationRemoteDatasource _notificationRemoteDatasource;
  final IChefRemoteStorageDataSource _chefRemoteStorageDataSource;

  AuthRepositoryImpl(
      this._authRemoteDatasource,
      this._userLocalStorageDataSource,
      this._userRemoteStorageDataSource,
      this._avatarRemoteDatasource,
      this._avatarLocalDatasource,
      this._notificationRemoteDatasource,
      this._chefRemoteStorageDataSource);

  @override
  Stream<User> get user => _authRemoteDatasource.firebaseUser
          .distinct(_checkEquality)
          .transform(StreamTransformer.fromHandlers(
              handleData: (firebaseUser, sink) async {
        _logger.d(
            '$hashCode received a firebase user:${firebaseUser == null ? "NULL" : firebaseUser.email}');
        User localUser;
        if (firebaseUser == null) {
          localUser = await _processUserNotAuthenticated();
          if (localUser != null) {
            _logger.d(
                'We could connect with local info, we descart this user object from stream');
            return;
          }
        } else {
          _logger.d('The user ${firebaseUser.email} is authenticated');
          if (firebaseUser.emailVerified) {
            _logger.d('Email is verified');
            localUser =
                await _processAuthenticatedUserWithEmailVerified(firebaseUser);
          } else {
            _logger.d('Email not verified, we refresh ths user');
            firebaseUser = await _authRemoteDatasource.refreshUser();
            if (firebaseUser.emailVerified) {
              _logger.d('Email is verified');
              localUser = await _processAuthenticatedUserWithEmailVerified(
                  firebaseUser);
            } else {
              _logger.d('Email not verified');
              localUser = User(
                  id: firebaseUser.uid,
                  email: firebaseUser.email,
                  isEmailVerified: false,
                  isAcceptedByChef: '');
            }
          }
        }
        sink.add(localUser);
      }));

  Future<User> _processUserNotAuthenticated() async {
    User localUser = _userLocalStorageDataSource.getUser();
    if (localUser == null) {
      //first use of the app
      //nothing to do
      _logger.d(
          'There is no user info en local storage, so we go to login page!!!');
    } else {
      //the user has already logged in and he has his info en local
      //so we use that to loign
      _logger.d(
          'The user ${localUser.email} is not logged but he has info en local, we login with that');
      try {
        await _authRemoteDatasource.refreshUserToken(
            email: localUser.email, pass: localUser.pass);
      } on firebase.FirebaseAuthException catch (e) {
        bool deleteLocalInfo = false;
        if (e.code == _USER_NOT_FOUND) {
          _logger.d('The user ${localUser.email} stored en local not found!!!');
          deleteLocalInfo = true;
        } else if (e.code == _WRONG_PASSWORD) {
          _logger.d(
              'The password stored en local is not correct for the user ${localUser.email} !!!');
          deleteLocalInfo = true;
        } else {
          //TODO we have to catch network exceptions to improve
          _logger.e(e);
        }
        if (deleteLocalInfo) {
          _logger.d('we delete local info because is not correct!!!!');
          if (await _userLocalStorageDataSource.deleteUser()) {
            _logger.d('user ${localUser.email} local info has been deleted');
          } else {
            _logger.d(
                'user ${localUser.email} local info has NOT been deleted!!!');
          }
          //wo try also remove avatar image if exists
          _logger.d('we also try to remove the avatar if exists');
          _avatarLocalDatasource.removeAvatar();
        }
        localUser = null;
      }
    }
    return localUser;
  }

  Future<User> _processAuthenticatedUserWithEmailVerified(
      firebase.User firebaseUser) async {
    //The user is authenticated and have active session
    User localUser;
    //email verified
    _logger.d('The user ${firebaseUser.email} has the email verified');
    localUser = _userLocalStorageDataSource.getUser();
    if (localUser == null) {
      _logger.d(
          'The user ${firebaseUser.email} has just logged in and not local info not found, so we get it');
      localUser = await _userRemoteStorageDataSource.getUser( userId: firebaseUser.uid);
      if ((localUser.avatar != null && localUser.avatar.isNotEmpty) ||
          (localUser.remoteAvatar != null &&
              localUser.remoteAvatar.isNotEmpty)) {
        File fileForAvatar = await _avatarLocalDatasource.getFileForAvatar(
            localUser.avatar == null
                ? localUser.remoteAvatar.extension
                : localUser.avatar.extension);
        final avatarDownloaded = await _avatarRemoteDatasource.downloadAvatar(
            firebaseUser.uid, fileForAvatar);
        final avatarDowloadedOK = avatarDownloaded.value1;
        final avatarUrl = avatarDownloaded.value2;
        if (avatarDowloadedOK) {
          if (localUser.remoteAvatar != avatarUrl) {
            localUser = localUser.copyWith(remoteAvatar: avatarUrl);
            _logger.d(
                'the remote url is not correct en firestore, so we update it');
            await _userRemoteStorageDataSource.updateUserData(
                firebaseUser.uid, {UserConstants.REMOTE_AVATAR: avatarUrl});
          }
          if (localUser.avatar != fileForAvatar.path) {
            _logger.d(
                'The avatar stored en firestore is not equal to the new local path, so we update it in firestore');
            localUser = localUser.copyWith(avatar: fileForAvatar.path);
            await _userRemoteStorageDataSource.updateUserData(
                firebaseUser.uid, {UserConstants.AVATAR: fileForAvatar.path});
          }
        }
      }
      //we must also update the messaging token, because is a new instalacion
      final notificationToken = await _notificationRemoteDatasource.token;
      localUser = localUser.copyWith(notificationKey: notificationToken);
      await _userLocalStorageDataSource.saveUser(localUser);
      await _userRemoteStorageDataSource.updateUserData(
          firebaseUser.uid, {UserConstants.NOTIFICATION_KEY: notificationToken});
    }
    if (!localUser.isEmailVerified) {
      //update emailVerified en local and en firestore
      _logger.d('The user has email verified y it is not updated');
      localUser = localUser.copyWith(isEmailVerified: true);
      await _userLocalStorageDataSource
          .updateUserData({UserConstants.IS_EMAIL_VERIFIED: true});
      _logger.d('updated local with email verified');
      await _userRemoteStorageDataSource
          .updateUserData(localUser.id, {UserConstants.IS_EMAIL_VERIFIED: true});
      _logger.d('updated remote with email verified');
      await _sendNotificationNewUser(localUser);
    }
    //if local info show that user is not accepted by chef, we have to look en remote, we have to lookup
    //remote database
    if (!localUser.isConfirmedByChef()) {
      String isAcceptedByChef =
          await _userRemoteStorageDataSource.isAcceptedByChef(localUser.id);
      if (isAcceptedByChef == StringConstants.YES) {
        localUser = localUser.copyWith(isAcceptedByChef: StringConstants.YES);
        await _userLocalStorageDataSource
            .updateUserData({UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.YES});
      } else if (isAcceptedByChef == StringConstants.NO) {
        /*await _userLocalStorageDataSource.deleteUser();
        await _avatarLocalDatasource.removeAvatar();
        await _avatarRemoteDatasource.deleteAvatar(localUser.id);
        await _userRemoteStorageDataSource.deleteUser(localUser.id);
        await _authRemoteDatasource.deleteUser();
        await _authRemoteDatasource.logoutUser();*/
        //localUser = null;
        localUser = localUser.copyWith(isAcceptedByChef: StringConstants.NO);
        await _userLocalStorageDataSource
            .updateUserData({UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.NO});
      }
    }
    return localUser;
  }

  bool _checkEquality(firebase.User user1, firebase.User user2) {
    if (user1 == null && user2 == null) {
      return true;
    } else if ((user1 == null && user2 != null) ||
        (user1 != null && user2 == null)) {
      return false;
    } else if (user1.uid == user2.uid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either<AuthFailure, String>> registerUser(
      {String email, String pass}) async {
    try {
      _logger.d('vamos a registar el usuario $email');
      final userId =
          await _authRemoteDatasource.registerUser(email: email, pass: pass);
      _logger.d('Ya se ha registrado el usuario $email y su id es $userId');
      return right(userId);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.e(e);
      if (e.code == _EMAIL_ALREADY_IN_USE) {
        //Ya hay un usuario registrado con esta cuenta
        return left(EmailAlreadyInUse());
      } else if (e.code == _UNKNOWN_ERROR &&
          e.message.contains(_UNABLE_RESOLVE_HOST)) {
        return left(InternetNotAvailable());
      }
    } catch (other) {
      _logger.e(other);
      return left(AuthServerError());
    }
    return null;
  }

  @override
  Future<Either<AuthFailure, String>> loginUser(
      {String email, String pass}) async {
    try {
      _logger.d('vamos a realizar el login del usuario $email');
      final user =
          await _authRemoteDatasource.loginUser(email: email, pass: pass);
      return right(user.uid);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.d('firebase');
      _logger.e(e);
      if (e.code == _TOO_MANY_REQUEST) {
        return left(TooManyLoginRequest());
      } else if (e.code == _WRONG_PASSWORD) {
        return left(WrongPasswordOnLogin());
      } else if (e.code == _USER_NOT_FOUND) {
        return left(UserNotFoundOnLogin());
      } else if (e.code == _UNKNOWN_ERROR &&
          e.message.contains(_UNABLE_RESOLVE_HOST)) {
        return left(InternetNotAvailable());
      } else {
        return left(AuthServerError());
      }
    } catch (e) {
      _logger.e(e);
      return left(AuthServerError());
    }
  }

  Notification _getNotificationToChefForNewMemberLoggedUp(
          User newUser, User chef) =>
      Notification(
          title: NotificationConstants.NOTIFI_NEW_MEMBER_TITLE,
          body: '${newUser.email} quiere formar parte de tu equipo',
          type: NotificationType.newMember,
          from: newUser,
          to: chef);

  _sendNotificationNewUser(User newUser) async {
    if (!newUser.isDirector()) {
      final myChef = await _chefRemoteStorageDataSource.getMyChef(newUser);
      if (myChef != null) {
        final notif =
            _getNotificationToChefForNewMemberLoggedUp(newUser, myChef);
        await _notificationRemoteDatasource.sendNotification(notif);
      }
    }
    return;
  }

  @override
  bool get isUserAuthenticated => _authRemoteDatasource.isUserAuthenticated;

  @override
  String get userId => _authRemoteDatasource.userId;

  @override
  Future<Either<Failure,bool>> get isEmailVerified async {
    try {
      final isEmailVerified= await _authRemoteDatasource.isEmailVerified;
      return right(isEmailVerified);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.e(e);
      if (e.code == _UNKNOWN_ERROR &&
          e.message.contains(_UNABLE_RESOLVE_HOST)) {
        return left(InternetNotAvailable());
      } else {
        return left(AuthServerError());
      }
    } catch (e) {
      _logger.e(e);
      return left(AuthServerError());
    }
  }

  @override
  void logout() async {
   await _authRemoteDatasource.logoutUser();
  }

}
