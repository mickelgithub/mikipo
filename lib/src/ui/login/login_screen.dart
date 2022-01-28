import 'package:flutter/material.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/route/route_generator.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/component/bottom_sheet_widget.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/viewmodel/state/registration_login_state.dart';
import 'package:mikipo/src/ui/login/widget/login_header_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_footer_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_logup_steps.dart';
import 'package:mikipo/src/util/constants/errors_constants.dart';
import 'package:mikipo/src/util/constants/size_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';



class LoginScreen extends StatefulWidget {

  static final _logger = getLogger((LoginScreen).toString());

  const LoginScreen._();

  static Widget getLoginScreen(
      {@required BuildContext context,
        @required LoginLogupOperation operation,
        StepPage stepPage,
      User user}) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel= serviceLocator<LoginViewModel>();
        viewModel.init(stepPage, user, operation);
        return viewModel;
      },
      child: LoginScreen._(),
    );
  }

  static double getFormHeight(LoginViewModel viewModel) {

    if (viewModel.stepPage == StepPage.loginLogup && viewModel.operation== LoginLogupOperation.login) {
      return SizeConstants.FORM_LOGIN_HEIGHT;
    } else if (viewModel.stepPage == StepPage.loginLogup && viewModel.operation== LoginLogupOperation.logup) {
      return SizeConstants.FORM_LOGUP_HEIGHT;
    } else if (viewModel.stepPage == StepPage.inputProfile) {
      return SizeConstants.FORM_JOB_PROFILE_HEIGHT;
    } else if (viewModel.stepPage == StepPage.validateMail || viewModel.stepPage == StepPage.waitBossResponse) {
      return SizeConstants.FORM_LOGIN_HEIGHT;
    }
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //StepPage get stepPage => widget._stepPage;
  //User get user => widget._user;



  @override
  void initState() {
    super.initState();

    LoginViewModel viewModel =
    Provider.of<LoginViewModel>(context, listen: false);
    
    viewModel.registrationStateObservable.addListener(() {
      _HandleLoginLogup(viewModel);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.updatePage();
    });
  }

  void _HandleLoginLogup(LoginViewModel viewModel) {
    if (viewModel.registrationState== null) {
      BottomSheetWidget.hideBottomSheet(context);
    } else if (viewModel.registrationState is LoginUserDisabled) {
      final error= ErrorsConstants.TEMPORARILY_OUT_OF_SERVICE;
      Navigator.of(context).pushReplacementNamed(RouteGenerator.INFO_ROUTE, arguments: error);
    } else if (viewModel.registrationState is LoginUserDischarged) {
      final error= ErrorsConstants.OUT_OF_SERVICE;
      Navigator.of(context).pushReplacementNamed(RouteGenerator.INFO_ROUTE, arguments: error);
    } else if (viewModel.registrationState is RegistrationLoginLogupStateError) {
      String message= (viewModel.registrationState as RegistrationLoginLogupStateError).message;
      BottomSheetWidget.showMessageBottomSheetWidget(context: context, message: message);
    } else if (viewModel.registrationState is RegistrationLoginLogupStateLoading) {
      BottomSheetWidget.showModalSheetForLoadingSuccess(context: context, feedback: BottonSheetFeedback.loading);
    } else if (viewModel.registrationState is RegistrationLoginLogupStateOk) {
      BottomSheetWidget.showModalSheetForLoadingSuccess(context: context, feedback: BottonSheetFeedback.success);
    } else if (viewModel.registrationState is LoginStateOK) {
      final user= (viewModel.registrationState as LoginStateOK).user;
      if (!user.isEmailVerified) {
        final args= {RouteGenerator.USER_ARG: user, RouteGenerator.STEP_PAGE_ARG: StepPage.validateMail, RouteGenerator.OPERATION_ARG: LoginLogupOperation.logup};
        Navigator.of(context).pushReplacementNamed(RouteGenerator.LOGIN_ROUTE, arguments: args);
      } else {
        if (!user.isConfirmedByChef()) {
          final args= {RouteGenerator.USER_ARG: user, RouteGenerator.STEP_PAGE_ARG: StepPage.waitBossResponse, RouteGenerator.OPERATION_ARG: LoginLogupOperation.logup};
          Navigator.of(context).pushReplacementNamed(RouteGenerator.LOGIN_ROUTE, arguments: args);
        } else {
          if (user.isConfirmedPositive()) {
            final args= {RouteGenerator.USER_ARG: user};
            Navigator.of(context).pushReplacementNamed(RouteGenerator.HOME_ROUTE, arguments: args);
          } else {
            final args = {
              RouteGenerator.USER_ARG: user,
              RouteGenerator.OPERATION_ARG: LoginLogupOperation.updateProfile
            };
            Navigator.of(context).pushReplacementNamed(
                RouteGenerator.LOGIN_ROUTE, arguments: args);
          }
        }
      }
    }
  }

  double _getHeaderHeight(Size size) {
    return size.height * SizeConstants.HEADER_HEIGHT_FACTOR;;
  }

  double _getFooterHeight(Size size) {
    return _getHeaderHeight(size) / 2;
  }

  @override
  Widget build(BuildContext context) {

    LoginScreen._logger.d('build...LoginScreen$hashCode');

    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Palette.white,
        )),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: _getHeaderHeight(size),
          child: LoginHeaderWidget(_getHeaderHeight(size), size.width),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: LoginFooterWidget(_getFooterHeight(size), size.width),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: LoginLogupSteps(),
          ),
        ),
      ],
    );

  }

}
