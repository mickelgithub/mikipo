import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/route/route_generator.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/splash/state/auth_state.dart';
import 'package:mikipo/src/ui/splash/viewmodel/splash_viewmodel.dart';
import 'package:mikipo/src/util/constants/errors_constants.dart';
import 'package:mikipo/src/util/constants/image_constants.dart';
import 'package:mikipo/src/util/constants/size_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  static final _logger = getLogger((SplashScreen).toString());

  const SplashScreen._();

  static Widget getSplashScreen({@required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_) => serviceLocator<SplashViewModel>(),
      child: SplashScreen._(),
    );
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _init(SplashViewModel viewModel) async {
    final result = await viewModel.getAuthState();

    //InternetNotAvailable(),ServerError(),AuthServerError(),UserNotFoundOnRemoteDatabase()
    //UserDischarged(),UserDisabled()
    //UserNotAuthenticatedButNotNew
    //UserNotAuthenticated

    if (result is AuthStateFailure) {
      String error;
      if (result.failure is InternetNotAvailable) {
        error= ErrorsConstants.NETWORK_ERROR_AND_TRY;
      } else if (result.failure is UserDischarged) {
        error= ErrorsConstants.OUT_OF_SERVICE;
      } else if (result.failure is UserDisabled) {
        error= ErrorsConstants.TEMPORARILY_OUT_OF_SERVICE;
      } else {
        error = ErrorsConstants.SERVER_ERROR;
      }
      Navigator.of(context).pushReplacementNamed(RouteGenerator.INFO_ROUTE, arguments: error);
    } else if (result is AuthStateNotAuthenticatedNewInstalation) {
      Navigator.of(context).pushReplacementNamed(RouteGenerator.LOGIN_ROUTE, arguments: {
        RouteGenerator.OPERATION_ARG: LoginLogupOperation.logup
      });
    } else if (result is AuthStateNotAuthenticatedButNotNew) {
      Navigator.of(context).pushReplacementNamed(
          RouteGenerator.LOGIN_ROUTE, arguments: {
            RouteGenerator.OPERATION_ARG: LoginLogupOperation.login
        }
        );
    } else if (result is AuthStateNotAuthenticatedBiometricEnabled) {
      final args = {
        RouteGenerator.LOCAL_STATE_INFO_ARG: result.localStateInfo
      };
      Navigator.of(context).pushReplacementNamed(
          RouteGenerator.BIOMETRIC_AUT_ROUTE, arguments: args);
    } else if (result is AuthStateNotAuthenticatedSavedCredentials) {
      //TODO we have to autenticate with the saved credentials
    } else if (result is AuthStateAuthenticated) {
      final user= result.user;
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<SplashViewModel>(context, listen: false);
      _init(viewModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    SplashScreen._logger.d('build...');
    return Scaffold(
      backgroundColor: Palette.white,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: Image.asset(
            ImageConstants.TEAM_ASSET,
            width: SizeConstants.SPLASH_IMAGE_WIDTH,
            height: SizeConstants.SPLASH_IMAGE_HEIGHT,
          ),
        ),
        Positioned(
          child: SpinKitCircle(
            size: SizeConstants.SPINKIT_SIZE,
            color: Theme.of(context).primaryColor,
          ),
          left: 0.0,
          right: 0.0,
          bottom: size.height * 0.15,
        )
      ],
    );
  }

  @override
  void dispose() {
    print('Dispose splashScreen...');
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}