import 'package:flutter/material.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/emailnotverified/email_not_verified.dart';
import 'package:mikipo/src/ui/home/home_screen.dart';
import 'package:mikipo/src/ui/home/viewmodel/home_view_model.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/waitbossacceptmembership/wait_boss_accept_membership.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:provider/provider.dart';
import 'package:mikipo/src/ui/splash/splash_screen.dart';



class AuthWidget_1 extends StatelessWidget {
  static final _logger = getLogger('AuthWidget');

  final AsyncSnapshot<User> userSnapshot;

  const AuthWidget_1({@required this.userSnapshot});

  //final _splashScreen = const SplashScreen();
  //final _loginScreen = const LoginScreen();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...AuthWidget$hashCode ${userSnapshot.connectionState}');
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        final user = userSnapshot.data;
        if (!user.isEmailVerified) {
          return EmailNotVerified();
        } else if (!user.isConfirmedByChef()) {
          return WaitBossAcceptMemberShip();
        } else if (user.isDeniedByChef()) {
          return Container();/*_getLoginScreen(
              loginLogupAction: LoginLogupOperation.updateProfile);*/
        } else {
          return _getHomeScreen(user);
        }
      } else {
        return _getLoginScreen();
      }
    }
    //TODOreturn SplashScreen();
    //return SplashScreen.getSplashScreen(context);
    return Container();
  }

  Widget _getHomeScreen(User user) {
    final viewModel = serviceLocator<HomeViewModel>();
    _logger.d(
        'Se ha creado el viewModel HomeViewModel con hash ${viewModel.hashCode}');
    return MultiProvider(
      builder: (_, __) => HomeScreen.getHomeScreen(context: null),//HomeScreen(viewModel, user),
      providers: [
        Provider<HomeViewModel>.value(value: viewModel),
        ChangeNotifierProvider<ValueNotifier<HomePage>>.value(
            value: null),
      ],
    );
    //return HomeScreen(viewModel);
  }

  Widget _getLoginScreen({LoginLogupOperation loginLogupAction}) {
    /*final viewModel = serviceLocator<LoginViewModel>();
    _logger.d(
        'Se ha creado el viewModel LoginViewModel con hash ${viewModel.hashCode}');
    return MultiProvider(
      builder: (_, __) => _loginScreen,
      providers: [
        Provider<LoginViewModel>.value(value: viewModel),
        ChangeNotifierProvider<ValueNotifier<File>>.value(
            value: viewModel.avatarImage),
        ChangeNotifierProvider<ValueNotifier<LoginLogupAction>>.value(
            value: viewModel.loginLogupAction),
        ChangeNotifierProvider<ValueNotifier<KeyBoardState>>.value(
            value: viewModel.keyBoardState),
        ChangeNotifierProvider<ValueNotifier<RegistrationStep>>.value(
            value: viewModel.registrationStep),
        ChangeNotifierProvider<ValueNotifier<List<Section>>>.value(
            value: viewModel.sections),
        ChangeNotifierProvider<ValueNotifier<List<HeighProfile>>>.value(
            value: viewModel.heighProfiles),
        ChangeNotifierProvider<ValueNotifier<List<Area>>>.value(
            value: viewModel.areas),
        ChangeNotifierProvider<ValueNotifier<List<Department>>>.value(
            value: viewModel.departments),
        ChangeNotifierProvider<ValueNotifier<bool>>.value(
            value: viewModel.registrationReady),
        ChangeNotifierProvider<ValueNotifier<RegistrationLoginState>>.value(
            value: viewModel.registrationState),
      ],
    );*/
    return ChangeNotifierProvider(
      create: (_) => serviceLocator<LoginViewModel>(),
      child: Container()//TODO LoginScreen(loginLogupAction: loginLogupAction),
    );
  }
}
