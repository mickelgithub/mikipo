import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';

part 'notification.freezed.dart';

enum NotificationType {
  newMember,
  acceptMember,
  denyMember
}

@freezed
abstract class Notification with _$Notification {

  static const String TO= 'notification_to';
  static const String FROM= 'notification_from';
  static const String TYPE= 'notification_type';
  static const String TITLE= 'notification_title';
  static const String BODY= 'notification_body';

  const factory Notification({User to, User from, NotificationType type, String title, String body, Map<String,dynamic> extraData})= _Notification;

}


