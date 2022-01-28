import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';

abstract class INotificationRepository {
  Future<String> get token;

  Future<Failure> sendNotification(Notification notification);
  Future<Failure> sendNewMemberNotificationToBoss(User user);

}
