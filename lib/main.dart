import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/di/injection_container.dart' as di;
import 'package:mikipo/src/messaging/messaging_handler.dart';
import 'package:mikipo/src/route/route_generator.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

void main() async {
  final logger = getLogger('main');

  logger.d('before initialization');
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static final _logger = getLogger('MyApp');

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    //fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);

    //TODO

    //final auth= serviceLocator<FirebaseAuth>();
    //auth.signOut();

  }

  @override
  Widget build(BuildContext context) {
    MyApp._logger.d('build...MyApp:$hashCode');


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiKipo',
      theme: ThemeData(
        primaryColor: Palette.ldaColor,
        accentColor: Palette.penelopeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteGenerator.SPLASH_ROUTE,
      onGenerateRoute: RouteGenerator.generateRoute,
    );

  }
}

