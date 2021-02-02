import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mikipo/framework/auth/auth_repository_impl.dart';
import 'package:mikipo/ui/auth/auth_widget.dart';
import 'package:mikipo/ui/auth/viewmodel/auth_view_model.dart';
import 'package:mikipo/ui/login/login_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthWidget(AuthViewModel(AuthRepositoryImpl(FirebaseAuth.instance))));
      case '/login':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
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