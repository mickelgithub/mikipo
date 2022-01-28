import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/usecase/auth/get_user_stream_usecase.dart';
import 'package:mikipo/src/ui/auth/auth_builder_widget/viewmodel/auth_builder_widget_view_model.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

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
  final logger = getLogger('_AuthBuilderWidgetState');

  Stream<User> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = widget.viewModel.user;

    /*_firebaseMessaging.getToken().then((String token) {
      print('my token:$token');
    });*/

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!!!!!!!!!!!!!!!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    logger.d('build...AuthBuilderWidget$hashCode');
    return StreamBuilder<User>(
      stream: _userStream,
      builder: (context, snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(
                value: user,
              ),
              Provider<GetUserStreamUseCase>.value(
                value: widget.viewModel.getUserStreamUseCase,
              ),
            ],
            child: widget.builder(context, snapshot),
          );
          /*
          return Provider<User>.value(
            value: user,
            child: widget.builder(context, snapshot),
          );*/
        }
        return widget.builder(context, snapshot);
      },
    );
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}
