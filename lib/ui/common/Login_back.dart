import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mikipo/ui/login/login_screen_v0.dart' as LoginScreen;

class LoginBackgroundPainter extends CustomPainter {
  final Paint colorLogupPaint;
  final Paint colorLoginPaint;

  final Animation _logupAnim;
  final Animation _loginAnim;

  final LoginScreen.Action _action;

  LoginBackgroundPainter({Animation<double> animation, LoginScreen.Action action, @required Color colorLogup, @required Color colorLogin})
      : colorLogupPaint = Paint()
          ..color = colorLogup
          ..style = PaintingStyle.fill,
        colorLoginPaint = Paint()
          ..color = colorLogin
          ..style = PaintingStyle.fill,
        _logupAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
                reverseCurve: Curves.easeInBack,)),
        _loginAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
                reverseCurve: Curves.easeInBack)),
        _action = action,
        super(repaint: animation) {
    print('${this.hashCode}........................');
  }

  @override
  void paint(Canvas canvas, Size size) {

    if (_action != LoginScreen.Action.initial) {
      _drawLogin(canvas, size, colorLoginPaint, _loginAnim);
    }
    _drawLogup(canvas, size, colorLogupPaint, _logupAnim);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawLogup(Canvas canvas, Size size, Paint paint, Animation anim) {
    final w = size.width;
    final h= size.height;
    final Rect rect= Rect.fromLTWH(0, 0, w, h/15* anim.value);
    canvas.drawRect(rect, paint);
  }

  void _drawLogin(Canvas canvas, Size size, Paint paint, Animation anim) {
    final w = size.width;
    final h= size.height;
    final Rect rect= Rect.fromLTWH(0, h/15*(1- anim.value), w, h/15* anim.value);
    canvas.drawRect(rect, paint);
  }

  /*void _paintUpperLeftShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    canvas.drawCircle(Offset(0, 0), 0.35 * h * _registrationAnim.value, paint);
  }

  void _paintUpperRightShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    canvas.drawCircle(Offset(w, 0), 0.35 * h * _loginAnim.value, paint);
  }*/

  /*void _paintUpperCenterShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    Path path = Path();
    path.moveTo(w - 0.15 * w, 0);
    path.quadraticBezierTo(
        0.45 * w, 0.35 * h + sin(_registrationAnim.value) * 0.05 * h, 0, 0.10 * h);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _paintLeftButtomShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    double radius = h / 40 + sin(_registrationAnim.value) * 0.05 * w;
    canvas.drawCircle(Offset(0, h - 2 * h / 40 - 10), radius, paint);
  }

  void _paintRightButtomShape(Canvas canvas, Size size, Paint paint) {
    final w = size.width;
    final h = size.height;
    double radius = h / 10;
    canvas.drawCircle(Offset(w + 10, h + 10), radius, paint);
  }*/
}
