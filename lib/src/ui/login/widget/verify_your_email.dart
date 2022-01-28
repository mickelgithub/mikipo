import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/util/constants/size_constants.dart';
import 'package:provider/provider.dart';

class VerifyYourEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context, listen: false);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Palette.ldaColor,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Palette.black.withOpacity(0.5),
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      height: LoginScreen.getFormHeight(viewModel),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Palette.white,
              ),
              child: Image.asset(
                'assets/images/team.png',
                width: SizeConstants.SPLASH_IMAGE_WIDTH / 2.5,
                height: SizeConstants.SPLASH_IMAGE_HEIGHT / 2.5,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Palette.white,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      'Ya estas dado de alta en el sistema, te hemos enviado un correo, revisarlo y pulsar continuar para completar tu registro',
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onSurface: Palette.white,
                      primary: Palette.ldaColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Siguiente',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                            viewModel.submitLoginLogupForm();
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
