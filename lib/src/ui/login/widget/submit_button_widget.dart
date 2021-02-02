import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class SubmitButtonWidget extends StatelessWidget {

  static final _logger= getLogger((SubmitButtonWidget).toString());

  const SubmitButtonWidget();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    final size = MediaQuery.of(context).size;
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    final inicialTop = FORM_OFFSET_UP + SUBMIT_BUTTON_SIZE / 2 + 10;
    return Consumer4<
        ValueNotifier<LoginLogupAction>,
        ValueNotifier<KeyBoardState>,
        ValueNotifier<bool>,
        ValueNotifier<RegistrationStep>>(
      builder: (context, action, keyboardState, registrationReady,
          registrationStep, _) {
        double top = size.height * 0.4;
        top = top - inicialTop;
        top += (action.value == LoginLogupAction.logup
            ? FORM_LOGUP_HEIGHT
            : FORM_LOGIN_HEIGHT);
        top -= (keyboardState.value == KeyBoardState.opened
            ? FORM_TRANSLATION_Y
            : 0.0);
        if (registrationStep.value == RegistrationStep.moving ||
            registrationStep.value == RegistrationStep.end) {
          top+= 60.0;
        }
        return AnimatedPositioned(
          top: top,
          right: 0,
          left: 0,
          duration: Duration(milliseconds: ANIM_DURATION),
          child: Center(
            child: StreamBuilder(
              stream: action.value == LoginLogupAction.login
                  ? viewModel.loginFormViewModel.submitLogin
                  : viewModel.loginFormViewModel.submitLogup,
              builder: (_, snapshot) => snapshot.hasData
                  ? _getEnabledSubmitButton(viewModel.onSubmitForm,
                      registrationReady.value, registrationStep.value)
                  : _getDisabledSubmitButton(),
            ),
          ),
        );
      },
    );
  }
}

Widget _getEnabledSubmitButton(VoidCallback onSubmitButtonClick,
    bool registrationReady, RegistrationStep registrationStep) {
  return TweenAnimationBuilder(
    duration: Duration(milliseconds: ANIM_DURATION * 4),
    curve: Curves.ease,
    tween: Tween<double>(
      begin: 0.0,
      end: registrationStep == RegistrationStep.moving ||
              registrationStep == RegistrationStep.end
          ? 1.0
          : 0.0,
    ),
    builder: (_, animation, child) {
      return InkWell(
        onTap: onSubmitButtonClick,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SUBMIT_BUTTON_SIZE*(1- animation)+ 10*animation),
        ),
        child: SizedBox(
          width: SUBMIT_BUTTON_SIZE + 20+ animation*20,
          height: (SUBMIT_BUTTON_SIZE + 20)*(1- animation)+ 50*animation,
          child: Center(
            child: Container(
              width: SUBMIT_BUTTON_SIZE+ animation*20,
              height: SUBMIT_BUTTON_SIZE*(1- animation)+ 50*animation,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SUBMIT_BUTTON_SIZE*(1- animation)+ 10*animation),
                gradient: LinearGradient(
                    colors: _getGradientColors(registrationReady, registrationStep),
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                boxShadow: [
                  BoxShadow(
                    color: Palette.black.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                tween: Tween<double>(
                    begin: 0.0, end: registrationReady ? -pi / 2 : 0.0),
                builder: (_, animation, child) {
                  return Transform.rotate(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Palette.white,
                      size:
                          (SUBMIT_BUTTON_SIZE / 2) + sin(-animation * 2) * 10,
                    ),
                    angle: animation,
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

List<Color> _getGradientColors(bool registrationReady, RegistrationStep registrationStep) {

  if (registrationStep== RegistrationStep.start
      || registrationStep== RegistrationStep.moving
      || (registrationStep== RegistrationStep.end && registrationReady)) {
    return [Palette.ldaColor, Palette.penelopeColor];
  } else {
    return [Colors.blueGrey[700], Colors.grey[600]];
  }
}

Widget _getDisabledSubmitButton() {
  return SizedBox(
    width: SUBMIT_BUTTON_SIZE + 20,
    height: SUBMIT_BUTTON_SIZE + 20,
    child: Center(
      child: Container(
        width: SUBMIT_BUTTON_SIZE,
        height: SUBMIT_BUTTON_SIZE,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SUBMIT_BUTTON_SIZE),
          gradient: LinearGradient(
              colors: [Colors.blueGrey[700], Colors.grey[600]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.ban,
            color: Palette.white,
            size: SUBMIT_BUTTON_SIZE / 2,
          ),
        ),
      ),
    ),
  );
}
