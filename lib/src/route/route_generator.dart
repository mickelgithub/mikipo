import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/emailnotverified/email_not_verified.dart';
import 'package:mikipo/src/ui/home/home_screen.dart';
import 'package:mikipo/src/ui/info/info_screen.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/splash/splash_screen.dart';

class RouteGenerator {

  static const SPLASH_ROUTE= '/';
  static const LOGIN_ROUTE= '/login';
  static const HOME_ROUTE= '/home';
  static const INFO_ROUTE= '/info';
  static const BIOMETRIC_AUT_ROUTE= 'biometric_auth';

  static const USER_ARG= 'user';
  static const STEP_PAGE_ARG= 'step_page';
  static const OPERATION_ARG= 'operation';
  static const LOCAL_STATE_INFO_ARG= 'local_state';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (context) => SplashScreen.getSplashScreen(context: context));
      case LOGIN_ROUTE :
        // Validation of correct data type
        /*if (args!= null && !(args is Map)) {
          return _errorRoute();
        }
        if (args== null) {
          return MaterialPageRoute(
            builder: (context) => LoginScreen.getLoginScreen(context: context),
          );
        }*/
        return MaterialPageRoute(
          builder: (context) => LoginScreen.getLoginScreen(context: context, stepPage: (args as Map)[STEP_PAGE_ARG], user: (args as Map)[USER_ARG], operation: (args as Map)[OPERATION_ARG]),
        );
      case HOME_ROUTE:
        if (args== null || !(args is Map)) {
          return _errorRoute();
        }
        return MaterialPageRoute(
          builder: (context) => HomeScreen.getHomeScreen(context: context, user: (args as Map)[USER_ARG]),
        );
      case '/email_not_verified':
        return MaterialPageRoute(
          builder: (_) => EmailNotVerified(),
        );
      case INFO_ROUTE:
        if (args!= null && args is String) {
          return MaterialPageRoute(builder: (context) => InfoScreen.getInfoScreen(context: context, message: args),);
        }
        return _errorRoute();
      case BIOMETRIC_AUT_ROUTE:
        if (args== null && !(args is Map)) {
          return _errorRoute();
        }
        //TODO
        return MaterialPageRoute(builder: (context) => InfoScreen.getInfoScreen(context: context, message: args),);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
