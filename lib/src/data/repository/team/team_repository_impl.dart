import 'package:meta/meta.dart';
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/team/team_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/team/team_repository.dart';
import 'package:mikipo/src/util/constants/string_constants.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';

class TeamRepositoryImpl implements ITeamRepository {
  static final _logger = getLogger((TeamRepositoryImpl).toString());

  static const String _NOTIFI_ACCEPT_MEMBER_TITLE = 'Ya estas dentro';
  static const String _NOTIFI_DENY_MEMBER_TITLE = 'Notificación de rechazo';

  final ITeamRemoteDatasource _teamRemoteDatasource;
  final IUserRemoteStorageDataSource _userRemoteStorageDataSource;
  final INotificationRemoteDatasource _notificationRemoteDatasource;
  final IUserLocalDataSource _userLocalStorageDataSource;
  final IAvatarLocalDatasource _avatarLocalDatasource;
  final IAvatarRemoteDatasource _avatarRemoteDatasource;
  final IAuthRemoteDatasource _authRemoteDatasource;

  TeamRepositoryImpl(
      this._teamRemoteDatasource,
      this._userRemoteStorageDataSource,
      this._notificationRemoteDatasource,
      this._userLocalStorageDataSource,
      this._avatarLocalDatasource,
      this._avatarRemoteDatasource,
      this._authRemoteDatasource);

  @override
  Future<List<User>> getTeamMembers(User user) =>
      _teamRemoteDatasource.getTeamMembers(user);

  @override
  Future<void> acceptDenyMember(
      {@required User chef,
      @required User member,
      @required bool accept}) async {
    if (accept) {
      await _acceptMember(chef: chef, member: member);
    } else {
      await _denyMember(chef: chef, member: member);
    }
  }

  Notification _getAcceptDenyNotification(
          {@required User chef,
          @required User member,
          @required bool accept}) =>
      Notification(
          title:
              accept ? _NOTIFI_ACCEPT_MEMBER_TITLE : _NOTIFI_DENY_MEMBER_TITLE,
          body: accept
              ? '${chef.email} te ha aprobado como miembro del equipo'
              : '${chef.email} te ha rechazado como miembro del equipo',
          type: accept
              ? NotificationType.acceptMember
              : NotificationType.denyMember,
          from: chef,
          to: member,
          extraData: {
            Notification.TYPE: accept
                ? NotificationType.acceptMember.toString()
                : NotificationType.denyMember.toString()
          });

  Future<void> _acceptMember({User chef, User member}) async {
    //update the field is_accepted_by_chef to true
    await _userRemoteStorageDataSource.updateUserData(
        member.id, {UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.YES});
    //send notification to member
    await _notificationRemoteDatasource.sendNotification(
        _getAcceptDenyNotification(chef: chef, member: member, accept: true));
  }

  Future<void> _denyMember({User chef, User member}) async {
    await _userRemoteStorageDataSource.updateUserData(
        member.id, {UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.NO});
    await _notificationRemoteDatasource.sendNotification(
        _getAcceptDenyNotification(chef: chef, member: member, accept: false));
  }

  @override
  Future<void> handleAcceptDenyMemberNotification(
      String userId, bool accept) async {
    if (accept) {
      await _userLocalStorageDataSource
          .updateUserData({UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.YES});
      _logger.d('I handled de accept notification updating local info');
    } else {
      await _userLocalStorageDataSource
          .updateUserData({UserConstants.IS_ACCEPTED_BY_CHEF: StringConstants.NO});
      //await _userLocalStorageDataSource.deleteUser();
      //await _avatarLocalDatasource.removeAvatar();
      //await _avatarRemoteDatasource.deleteAvatar(userId);
      //await _userRemoteStorageDataSource.deleteUser(userId);
      //await _authRemoteDatasource.deleteUser();
      //await _authRemoteDatasource.logoutUser();
      _logger.d('I handled de deny notification updating local info');
    }
  }
}
