import 'package:meta/meta.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/exception.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/domain/entity/notification/notification_failure.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class NotificationRepositoryImpl implements INotificationRepository {

  static const _NEW_MEMBER_NOTIFICATION_TITLE= 'Nuevo miembro';
  static const _NEW_MEMBER_NOTIFICATION_BODY= 'Se ha dado de alta un nuevo miembro';

  static final _logger = getLogger((NotificationRepositoryImpl).toString());

  final INotificationRemoteDatasource _notificationRemoteDatasource;
  final IChefRemoteStorageDataSource _chefRemoteStorageDataSource;

  NotificationRepositoryImpl(this._notificationRemoteDatasource, this._chefRemoteStorageDataSource);

  @override
  Future<String> get token async => await _notificationRemoteDatasource.token;

  @override
  Future<Failure> sendNotification(Notification notification) async {
    try {
      await _notificationRemoteDatasource.sendNotification(notification);
    } on CustomException catch (e) {
      _logger.e(e);
      if (e.cause== CustomCause.notifRecipientIncorrect) {
        return RecipientNotCorrect();
      } else {
        return ServerError();
      }
    }
  }

  @override
  Future<Failure> sendNewMemberNotificationToBoss(User user) async {
    try {
      final myBoss= await _chefRemoteStorageDataSource.getMyChef(user);
      if (myBoss!= null) {
        await _notificationRemoteDatasource.sendNotification(_geNewMemberNotification(member: user, chef: myBoss));
        _logger.d('We have sent the new member notification from member ${user.email} to ${myBoss.email}');
      }
    } catch (e) {
      print(e);
    }
  }

  Notification _geNewMemberNotification({@required User member, @required User chef}) {
    return Notification(
        to: chef,
        from: member,
        title: _NEW_MEMBER_NOTIFICATION_TITLE,
        type: NotificationType.newMember,
        body: '${_NEW_MEMBER_NOTIFICATION_BODY} ${member.email}');
  }

}
