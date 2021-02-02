import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';

class NotificationRepositoryImpl implements INotificationRepository {

  final INotificationRemoteDatasource _notificationRemoteDatasource;

  NotificationRepositoryImpl(this._notificationRemoteDatasource);

  @override
  Future<String> get token async => await _notificationRemoteDatasource.token;

  @override
  Future<String> sendNotification(Notification notification) async => await _notificationRemoteDatasource.sendNotification(notification);




}