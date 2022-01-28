import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/exception.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class UserRepositoryImpl implements IUserRepository {

  static const String _UNAVAILABLE = 'unavailable';

  static final _logger = getLogger((UserRepositoryImpl).toString());

  final IUserLocalDataSource _userLocalStorageDataSource;
  final IUserRemoteStorageDataSource _userRemoteStorageDataSource;

  UserRepositoryImpl(
      this._userLocalStorageDataSource, this._userRemoteStorageDataSource);

  @override
  Future<Either<Failure,User>> getUser(String userId) async {
    try {
      return right(await _userRemoteStorageDataSource.getUser(userId: userId));
    } on firestore.FirebaseException catch (e) {
      _logger.e(e);
      if (e.code == _UNAVAILABLE) {
        return left(InternetNotAvailable());
      } else {
        return left(ServerError());
      }
    } on CustomException catch (ce) {
      if (ce.cause== CustomCause.userNotFound)
      return left(UserNotFoundOnRemoteDatabase());
    }
  }

  @override
  Future<void> updateUserEmailVerified(String userId) async {
    await _userRemoteStorageDataSource.updateUserData(userId, {UserConstants.IS_EMAIL_VERIFIED: true});
  }

  //***********************************************************************************************************

  @override
  Future<void> saveUser(User user) async {
    await _userRemoteStorageDataSource.saveUser(user);

    //TODO hay que cambiar
    await _userLocalStorageDataSource.saveUser(user);
  }



  @override
  Future<void> updateUserHeighProfile(
      {@required String userId,
      @required HeighProfile heighProfile,
      @required Section section,
      Area area,
      Department department}) async {
    bool deleteArea = false;
    bool deleteDepartment = false;
    Map<String, dynamic> data = {
      HeighProfile.ID: heighProfile.id,
      HeighProfile.NAME: heighProfile.name,
      HeighProfile.LEVEL: heighProfile.level,
      Section.ID: section.id,
      Section.NAME: section.name,
      Section.ICON: section.icon
    };
    //update local data
    if (area != null) {
      data.addAll(
          {Area.ID: area.id, Area.NAME: area.name, Area.ICON: area.icon});
    } else {
      deleteArea = true;
    }
    if (department != null) {
      data.addAll(
          {Department.ID: department.id, Department.NAME: department.name});
    } else {
      deleteDepartment = true;
    }
    _userLocalStorageDataSource.updateUserData(data);
    if (deleteArea) {
      await _userLocalStorageDataSource
          .deleteData([Area.ID, Area.NAME, Area.ICON]);
    }
    if (deleteDepartment) {
      await _userLocalStorageDataSource
          .deleteData([Department.ID, Department.NAME]);
    }
    //update remote data
    await _userRemoteStorageDataSource.updateUserData(userId, data);
  }


}
