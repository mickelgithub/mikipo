import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/widget/matias_feedback.dart';

class WaitBossAcceptMemberShip extends StatelessWidget {

  const WaitBossAcceptMemberShip();

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    final top= (size.height- 226)/2;

    Future.delayed(const Duration(milliseconds: 7000), () async {
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    });

    return SafeArea(
        child: Scaffold(
          backgroundColor: Palette.feedback_backgroud_color,
          body: MatiasFeedback(feedback: 'He enviado una notificación a tu responsable.\nEspera una respuesta...'),
        ));
  }
}
