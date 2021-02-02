import 'package:mikipo/src/domain/entity/notification/notification.dart';

abstract class INotificationRemoteDatasource {

  Future<String> get token;

  Future<String> sendNotification(Notification notification);

}