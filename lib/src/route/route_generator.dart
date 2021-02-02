import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/emailnotverified/email_not_verified.dart';
import 'package:mikipo/src/ui/home/home_screen.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      /*case '/':
        return MaterialPageRoute(builder: (_) => AuthWidget());*/
      case '/login':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      /*case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );*/
      case '/email_not_verified':
        return MaterialPageRoute(
          builder: (_) => EmailNotVerified(),
        );
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