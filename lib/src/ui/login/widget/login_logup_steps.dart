import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/widget/job_profile_form_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_logup_form_widget.dart';
import 'package:mikipo/src/ui/login/widget/verify_your_email.dart';
import 'package:mikipo/src/ui/login/widget/wait_boss_response.dart';
import 'package:mikipo/src/util/constants/animation_constants.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoginLogupSteps extends StatelessWidget {
  static const int PAGES_COUNT = 4;

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: AnimationConstants.ANIM_DURATION),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        height: LoginScreen.getFormHeight(viewModel),
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: viewModel.loginLogupStepsPageViewController,
          itemCount: PAGES_COUNT,
          itemBuilder: (_, index) {
            Widget page;
            switch (index) {
              case 0:
                page = LoginLogupFormWidget();
                break;
              case 1:
                page = JobProfileFormWidget();
                break;
              case 2:
                page= VerifyYourEmail();
                break;
              case 3:
                page= WaitBossResponseWidget();
                break;
              default:
                return null;
            }
            final percent = (viewModel.pageScroll ?? 0.0) - index;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(vector.radians(45 * percent)),
              child: page,
            );
          },
        ),
      ),
    );
  }
}
