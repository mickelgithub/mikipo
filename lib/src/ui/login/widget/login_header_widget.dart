import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/widget/registration_login_feedback_widget.dart';
import 'package:mikipo/src/util/constants/image_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class LoginHeaderWidget extends StatelessWidget {
  static final _logger = getLogger((LoginHeaderWidget).toString());

  final double height;
  final double width;

  const LoginHeaderWidget(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    _logger.d('build...LoginHeaderWidget:$hashCode');

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.network(
            ImageConstants.TEAMWORK_IMAGE_URL,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Palette.penelopeColor.withOpacity(0.2),
          ),
        ),
        //const RegistrationLoginFeedbackWidget(),
      ],
    );
  }
}
