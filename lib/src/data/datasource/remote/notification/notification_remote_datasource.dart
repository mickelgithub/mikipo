import 'package:mikipo/src/domain/entity/notification/notification.dart';

abstract class INotificationRemoteDatasource {

  static const String RECIPIENT_INCORRECT= 'recipient incorrect';
  static const String ERROR_NOT_CONTROLLED= 'uncontrolled error';

  Future<String> get token;

  Future<void> sendNotification(Notification notification);
}
