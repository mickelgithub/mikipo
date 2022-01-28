import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/widget/matias_feedback.dart';

class EmailNotVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we close this page passed 10 seconds
    Future.delayed(const Duration(milliseconds: 7000), () async {
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    });

    return SafeArea(
        child: Scaffold(
      backgroundColor: Palette.feedback_backgroud_color,
      body: MatiasFeedback(
          feedback:
              'Te he enviado un correo\npara validar tu email.\nRevisalo para poder continuar...'),
    ));
  }
}
