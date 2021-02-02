import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/viewmodel/state/registration_login_state.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class RegistrationLoginFeedbackWidget extends StatelessWidget {

  static final _logger= getLogger((RegistrationLoginFeedbackWidget).toString());

  const RegistrationLoginFeedbackWidget();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    return Consumer<ValueNotifier<RegistrationLoginState>>(
      builder: (context, registrationLoginState, child) {
        if (registrationLoginState.value is RegistrationLoginStateError) {
          print('Hay error........................');
          String message= (registrationLoginState.value as RegistrationLoginStateError).message;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            // fetch data
            _showModalSheetForManageAvatar(context, message);
          });
        } else {
          print('No hubo ningiun error..................');
        }
        return child;
      },
      child: Container(
        color: Colors.transparent,
        width: 0.0,
        height: 0.0,),
    );
  }

  void _showModalSheetForManageAvatar(BuildContext context, String message) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message, style: TextStyle(color: Palette.ldaColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
                ),
              ],
            ),
          );
        });
  }
}
