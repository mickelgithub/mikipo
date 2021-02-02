import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/widget/registration_login_feedback_widget.dart';
import 'package:mikipo/src/util/constants/image_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class LoginHeaderWidget extends StatelessWidget {

  static final _logger= getLogger((LoginHeaderWidget).toString());

  const LoginHeaderWidget();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    final size = MediaQuery.of(context).size;
    double topBackHeight = size.height * HEADER_HEIGHT_FACTOR;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: topBackHeight,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Image.network(
              ImageConstants.TEAMWORK_IMAGE_URL,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            height: topBackHeight,
            width: size.width,
            decoration: BoxDecoration(
              color: Palette.penelopeColor.withOpacity(0.3),
            ),
          ),
          const RegistrationLoginFeedbackWidget(),
        ],
      ),
    );
  }
}
