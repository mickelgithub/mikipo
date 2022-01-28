import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/component/input_text_widget.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/widget/profile_avatar_widget.dart';
import 'package:provider/provider.dart';

class LoginLogupFormWidget extends StatelessWidget {
  static const String _LOGIN = 'Acceder';
  static const String _LOGUP = 'Registrarse';
  static const int ANIM_DURATION = 200;
  static const String _PASS_HINT = 'Contraseña';
  static const String _CONFIRM_PASS_HINT = 'Confirmar contraseña';

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScopeNode();

    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: ANIM_DURATION),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  splashColor: Palette.white.withOpacity(0.5),
                  onTap: viewModel.isOnlyLoginOperationAllowed ? null : () {
                    viewModel.changeLoginLogupOperation(LoginLogupOperation.login);
                  },
                  child: Text(
                    _LOGIN,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            viewModel.isLogin
                                ? Palette.white
                                : Palette.grey,
                        fontSize: 20.0),
                  ),
                ),
                ProfileAvatarWidget(),
                InkWell(
                  splashColor: Palette.white.withOpacity(0.5),
                  onTap: viewModel.isOnlyLoginOperationAllowed ? null : () {
                    viewModel.changeLoginLogupOperation(LoginLogupOperation.logup);
                  },
                  child: Text(
                    _LOGUP,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            !viewModel.isLogin
                                ? Palette.white
                                : Palette.grey,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
            viewModel.isLogin ? _getLoginForm(node, viewModel): _getLogupForm(node, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _getLogupForm(FocusScopeNode node, LoginViewModel viewModel) {
    return Expanded(
      child: Form(
        child: FocusScope(
          node: node,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //the first page
                _getEmailInput(node, viewModel),
                SizedBox(
                  height: 5,
                ),
                _getPassInput(node, viewModel, LoginLogupOperation.logup),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(0.0),
                    child: _getConfirmPassInput(node, viewModel),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: getNextButton(viewModel),
                  ),
                ),
              ],
              //the second page
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLoginForm(FocusScopeNode node, LoginViewModel viewModel) {
    return Expanded(
      child: Form(
        child: FocusScope(
          node: node,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //the first page
                  _getEmailInput(node, viewModel),
                  SizedBox(
                    height: 5,
                  ),
                  _getPassInput(node, viewModel, LoginLogupOperation.login),
                  SizedBox(
                    height: 15,
                  ),
                  getNextButton(viewModel),
                ],
                //the second page
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getNextButton(LoginViewModel viewModel) {
    return StreamBuilder(
      stream: viewModel.isLogin
          ? viewModel.loginFormViewModel.submitLogin
          : viewModel.loginFormViewModel.submitLogup,
      builder: (_, snapshot) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          onSurface: Palette.white,
          primary: Palette.ldaColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(
            width: 2,
            color:
                snapshot.hasData ? Colors.white : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Siguiente',
            style: TextStyle(
                fontSize: 16.0,
                color: snapshot.hasData
                    ? Colors.white
                    : Colors.white.withOpacity(0.5)),
          ),
        ),
        onPressed: snapshot.hasData
            ? () {
                viewModel.submitLoginLogupForm();
              }
            : null,
      ),
    );
  }

  Widget _getEmailInput(FocusScopeNode node, LoginViewModel viewModel) {
    return StreamBuilder(
      stream: viewModel.loginFormViewModel.email,
      builder: (_context, snapshot) => InputTextWidget(
        hintText: 'Email',
        textInputType: TextInputType.emailAddress,
        iconData: Icons.email,
        onChanged: viewModel.loginFormViewModel.changeEmail,
        error: snapshot.error,
        node: node,
        controller: viewModel.loginFormViewModel.editEmailController,
      ),
    );
  }

  Widget _getPassInput(
      FocusScopeNode node, LoginViewModel viewModel, LoginLogupOperation operation) {
    return StreamBuilder(
      stream: viewModel.loginFormViewModel.pass,
      builder: (_, snapshot) => InputTextWidget(
        hintText: _PASS_HINT,
        textInputType: TextInputType.text,
        iconData: Icons.lock,
        onChanged: viewModel.loginFormViewModel.changePass,
        error: snapshot.error,
        isDone: operation == LoginLogupOperation.login,
        moveFocusTwice: operation == LoginLogupOperation.logup,
        node: node,
        isPass: true,
        controller: viewModel.loginFormViewModel.editPassController,
      ),
    );
  }

  Widget _getConfirmPassInput(FocusScopeNode node, LoginViewModel viewModel) {
    return StreamBuilder<Object>(
      stream: viewModel.loginFormViewModel.confirmPass,
      builder: (_, snapshot) {
        return InputTextWidget(
          hintText: _CONFIRM_PASS_HINT,
          textInputType: TextInputType.text,
          iconData: Icons.lock,
          onChanged: viewModel.loginFormViewModel.changeConfirmPass,
          value: '',
          error: snapshot.error,
          isDone: true,
          node: node,
          isPass: true,
          controller: viewModel.loginFormViewModel.editConfirmPassController,
        );
      },
    );
  }
}
