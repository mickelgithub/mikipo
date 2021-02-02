import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/route/route_generator.dart';
import 'package:mikipo/src/di/injection_container.dart' as di;
import 'package:mikipo/src/ui/auth/auth_builder_widget/auth_builder_widget.dart';
import 'package:mikipo/src/ui/auth/auth_widget/auth_widget.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/messaging/messaging_handler.dart';

void main() async {
  final logger = getLogger('main');

  logger.d('before initializacion');
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initilization
  await Firebase.initializeApp();
  //dependencies container
  await di.init();
  //messaging
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  logger.d('after initializacion');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final _logger = getLogger('MyApp');

  @override
  Widget build(BuildContext context) {
    _logger.d('build...${hashCode}');
    //fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);
    return AuthBuilderWidget(
      viewModel: di.serviceLocator(),
      builder: (context, snapshot) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          indicatorColor: Palette.ldaColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWidget(
          userSnapshot: snapshot,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
