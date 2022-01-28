import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/domain/usecase/team/handle_accept_deny_member_notification_usecase.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/di/injection_container.dart' as di;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final _logger = getLogger('firebaseMessagingBackgroundHandler');

  print(
      "Handling a background message: ${message.messageId}: ${message.notification.title}: ${message.notification.body}");
  await Firebase.initializeApp();
  await di.init();
  _logger.d('${message.notification}');

  if (message.data != null && message.data.isNotEmpty) {
    final notificationType = message.data[Notification.TYPE] as String;
    if (notificationType != null && notificationType.isNotEmpty) {
      if (NotificationType.acceptMember.toString() == notificationType) {
        _logger.d('you have been accepted to be part of team');
        final handleAcceptUseCase =
            serviceLocator<HandleAcceptDenyMemberNotificationUseCase>();
        handleAcceptUseCase(true);
      } else if (NotificationType.denyMember.toString() == notificationType) {
        _logger.d('You have been denied to be part of team');
        final handleDenyUseCase =
            serviceLocator<HandleAcceptDenyMemberNotificationUseCase>();
        handleDenyUseCase(false);
      }
    }
  }
}
