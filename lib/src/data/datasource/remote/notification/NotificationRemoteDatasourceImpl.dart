import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mikipo/src/data/datasource/remote/notification/notification_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/notification/notification.dart';
import 'package:http/http.dart' as http;
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class NotificationRemoteDatasourceImpl implements INotificationRemoteDatasource {

  static const String _FLUTTER_NOTIFICATION_CLICK= 'FLUTTER_NOTIFICATION_CLICK';
  static const String _CONTENT_TYPE_HEADER= 'Content-Type';
  static const String _JSON_CONTENT_TYPE= 'application/json; charset=UTF-8';
  static const String _AUTHORIZATION_HEADER= 'Authorization';
  static const String _TO_KEY= 'to';
  static const String _NOTIFICATION_KEY= 'notification';
  static const String _NOTIFICATION_TITLE_KEY= 'title';
  static const String _NOTIFICATION_BODY_KEY= 'body';
  static const String _NOTIFICATION_DATA_KEY= 'data';
  static const String _CLICK_ACTION_LEY= 'click_action';

  static final _logger= getLogger((NotificationRemoteDatasourceImpl).toString());

  final FirebaseMessaging _firebaseMessaging;
  final http.Client _httpClient;
  final String _messagingServerUrl;
  final String _messagingServerKey;


  NotificationRemoteDatasourceImpl(this._firebaseMessaging, this._httpClient, this._messagingServerUrl, this._messagingServerKey);

  @override
  Future<String> get token async => await _firebaseMessaging.getToken();

  @override
  Future<String> sendNotification(Notification notification) async {

    Map<String, dynamic> data;
    _logger.d(data);
    final response= await _httpClient.post(
        _messagingServerUrl,
        headers: { _AUTHORIZATION_HEADER: 'key=${_messagingServerKey}',
          _CONTENT_TYPE_HEADER : _JSON_CONTENT_TYPE },
        body: jsonEncode(<String,dynamic>{
          _TO_KEY: notification.to.notificationKey,
          _NOTIFICATION_KEY: {
            _NOTIFICATION_TITLE_KEY: notification.title,
            _NOTIFICATION_BODY_KEY: notification.body,
            _NOTIFICATION_DATA_KEY: {
              _CLICK_ACTION_LEY: _FLUTTER_NOTIFICATION_CLICK
            }
          },
          _NOTIFICATION_DATA_KEY: notification.extraData!= null && notification.extraData.isNotEmpty ? notification.extraData : {}
      }
      ));
    if (response.statusCode== 200) {
      final bodyMap= jsonDecode(response.body);
      final sucess= (bodyMap['success'] as int);
      final error= (bodyMap['failure'] as int);
      if (sucess> 0 && error== 0) {
        _logger.d('ya hemos enviado correctamente la notificacion a ${notification.to.email}');
      } else {
        final error= (bodyMap['results'] as List).first['error'];
        _logger.d('Ha ocurrido este error al enviar la notificacion a ${notification.to.email} ---> ${error}');
      }
    }


  }

}