import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/auth/auth_builder_widget/viewmodel/auth_builder_widget_view_model.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {

  print('=============================  ');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];

  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class AuthBuilderWidget extends StatefulWidget {

  final AuthBuilderWidgetViewModel viewModel;
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  const AuthBuilderWidget(
      {Key key, @required this.viewModel, @required this.builder})
      : super(key: key);

  @override
  _AuthBuilderWidgetState createState() => _AuthBuilderWidgetState();
}

class _AuthBuilderWidgetState extends State<AuthBuilderWidget> {

  final logger= getLogger('_AuthBuilderWidgetState');

  Stream<User> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = widget.viewModel.user;

    /*_firebaseMessaging.getToken().then((String token) {
      print('my token:$token');
    });*/


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!!!!!!!!!!!!!!!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    logger.d('build...${hashCode}');
    return StreamBuilder<User>(
      stream: _userStream,
      builder: (context, snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          return Provider<User>.value(
            value: user,
            child: widget.builder(context, snapshot),
          );
        }
        return widget.builder(context, snapshot);
      },
    );
  }
}
