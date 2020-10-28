import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mikipo/ui/login/login_screen.dart' as LoginScreen;

import 'colors.dart';

class LoginBackgroundPainter extends CustomPainter {
  final Paint lightGreenPaint;
  final Paint blackPaint;

  final Animation _animation;
  // final Animation singUpAnimation;
  final Animation _animationLogin;

  final LoginScreen.Action _action;

  LoginBackgroundPainter({Animation<double> animation, LoginScreen.Action action})
      : lightGreenPaint = Paint()
          ..color = Palette.lightGreen
          ..style = PaintingStyle.fill,
        blackPaint = Paint()
          ..color = Palette.black
          ..style = PaintingStyle.fill,
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
                reverseCurve: Curves.bounceIn)),
        _animationLogin = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
                reverseCurve: Curves.bounceIn)),

        _action = action,
        /*ldaAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
            reverseCurve: Curves.bounceIn),*/
        super(repaint: animation) {
    print('${this.hashCode}........................');
  }

  @override
  void paint(Canvas canvas, Size size) {

    if (_action != LoginScreen.Action.initial) {
      _paintUpperRightShape(canvas, size, blackPaint);
    }
    _paintUpperLeftShape(canvas, size, lightGreenPaint);
    //_paintUpperCenterShape(canvas, size, lightGreenPaint);
    //_paintLeftButtomShape(canvas, size, lightGreenPaint);
    //_paintRightButtomShape(canvas, size, blackPaint);
    //_paintLda(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _paintUpperLeftShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    canvas.drawCircle(Offset(0, 0), 0.35 * h * _animation.value, paint);
  }

  void _paintUpperRightShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    canvas.drawCircle(Offset(w, 0), 0.35 * h * _animationLogin.value, paint);
  }

  void _paintUpperCenterShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    Path path = Path();
    path.moveTo(w - 0.15 * w, 0);
    path.quadraticBezierTo(
        0.45 * w, 0.35 * h + sin(_animation.value) * 0.05 * h, 0, 0.10 * h);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _paintLeftButtomShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    double radius = h / 40 + sin(_animation.value) * 0.05 * w;
    canvas.drawCircle(Offset(0, h - 2 * h / 40 - 10), radius, paint);
  }

  void _paintRightButtomShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    double radius = h / 10;
    canvas.drawCircle(Offset(w + 10, h + 10), radius, paint);
  }
}
