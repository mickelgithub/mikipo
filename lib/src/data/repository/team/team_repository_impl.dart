import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/team/team_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/team/team_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';

class TeamRepositoryImpl implements ITeamRepository {

  static final _logger= getLogger((TeamRepositoryImpl).toString());

  static const String _NOTIFI_ACCEPT_MEMBER_TITLE= 'Ya estas dentro';

  final ITeamRemoteDatasource _teamRemoteDatasource;
  final IUserRemoteStorageDataSource _userRemoteStorageDataSource;
  final INotificationRemoteDatasource _notificationRemoteDatasource;
  final IUserLocalStorageDataSource _userLocalStorageDataSource;

  TeamRepositoryImpl(this._teamRemoteDatasource, this._userRemoteStorageDataSource, this._notificationRemoteDatasource, this._userLocalStorageDataSource);

  @override
  Future<List<User>> getTeamMembers(User user) => _teamRemoteDatasource.getTeamMembers(user);

  @override
  Future<void> acceptDenyMember({User chef, User member, bool accept}) async {
    if (accept) {
      await _acceptMember(chef: chef, member: member);
    } else {
      await _denyMember(chef: chef, member: member);
    }
  }

  Notification _getAcceptNotification({User chef, User member}) => Notification(
      title: _NOTIFI_ACCEPT_MEMBER_TITLE,
      body: '${chef.email} te ha aprobado como miembro del equipo',
      type: NotificationType.acceptMember,
      from: chef,
      to: member,
      extraData: {Notification.TYPE: NotificationType.acceptMember.toString()}
  );

  void _acceptMember({User chef, User member}) async {
    //update the field is_accepted_by_chef to true
    await _userRemoteStorageDataSource.updateUserData(member.id, {User.IS_ACCEPTED_BY_CHEF: true});
    //send notification to member
    await _notificationRemoteDatasource.sendNotification(_getAcceptNotification(chef: chef, member: member));
  }

  void _denyMember({User chef, User member}) async {

  }

  @override
  Future<void> handleAcceptDenyMemberNotification(bool accept) async {
    if (accept) {
      await _userLocalStorageDataSource.updateUserData({User.IS_ACCEPTED_BY_CHEF: accept});
      _logger.d('I handled de accept notification updating local info');
    } else {
      //we have to delete user information from remote database
      //logout user
      //remove local info
      return;
    }
  }
}
