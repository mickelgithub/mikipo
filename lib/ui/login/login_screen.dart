import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/ui/comun/Login_back.dart';

enum Action {
  initial, logup, login
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _logupTextOpacity = 0;
  double _loginTextOpacity = 0;
  Action _action = Action.initial;
  double _logupLeft = 0;
  double _logupTop = 0;
  double _loginTop = 0;
  double _loginRight = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _executeAfterWholeBuildProcess(context));
  }

  @override
  Widget build(BuildContext context) {
    print("LoginScreen.....${hashCode}");

    return Scaffold(
        body: Stack(
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: LoginBackgroundPainter(
                animation: _animationController, action: _action),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          top: _logupTop,
          left: _logupLeft,
          child: AnimatedOpacity(
            opacity: _logupTextOpacity,
            duration: Duration(milliseconds: 300),
            child: Text(
              'Registrarse',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          top: _loginTop,
          right: _loginRight,
          child: AnimatedOpacity(
            opacity: 1 - _logupTextOpacity,
            duration: Duration(milliseconds: 300),
            child: Text(
              'Acceder',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            _swapLogupLogin(context);
          },
          child: Center(
            child: Text('Click her'),
          ),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _swapLogupLogin(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (_action == Action.logup || _action == Action.initial) {
      _action = Action.login;
      _logupLeft = 0;
      _logupTop = 0;
      _loginRight = screenSize.width / 10;
      _loginTop = screenSize.height / 10;
      _animationController.reverse();
      _logupTextOpacity = 0;
    } else {
      _action = Action.logup;
      _logupLeft = screenSize.width / 10;
      _logupTop = screenSize.height / 10;
      _loginRight = 0;
      _loginTop = 0;
      _animationController.forward();
      _logupTextOpacity = 1;
    }

    setState(() {});
  }

  void _executeAfterWholeBuildProcess(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _logupLeft = screenSize.width / 10;
    _logupTop = screenSize.height / 10;
    _animationController.forward();
    _logupTextOpacity = 1;
    setState(() {});
  }
}
