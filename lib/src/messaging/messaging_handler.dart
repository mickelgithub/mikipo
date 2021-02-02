import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mikipo/src/di/injection_container.dart' as di;
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:mikipo/src/domain/usecase/team/handle_accept_deny_member_notification_usecase.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

const String cad='';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  final _logger= getLogger('firebaseMessagingBackgroundHandler');

  print("Handling a background message: ${message.messageId}: ${message.notification.title}: ${message.notification.body}");
  await Firebase.initializeApp();
  //await di.init();
  _logger.d('11111111111111111111');
  _logger.d('${message.notification}');

  if (message.data!= null && message.data.isNotEmpty) {
    _logger.d('11111111111111111222');
    final notificationType= message.data[Notification.TYPE] as String;
    _logger.d('111111111111111111333');
    if (notificationType!= null && notificationType.isNotEmpty) {
      _logger.d('111111111111111111444');
      if (NotificationType.acceptMember.toString()== notificationType) {
        _logger.d('Se ha recebido una notificacion de aceptacion en el equipo');
        final handleAcceptUseCase= serviceLocator<HandleAcceptDenyMemberNotificationUseCase>();
        handleAcceptUseCase(true);
      } else {
        _logger.d('11111111111111115555');
      }
    }
  }



}