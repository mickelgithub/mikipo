import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/di/injection_container.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/ui/emailnotverified/email_not_verified.dart';
import 'package:mikipo/src/ui/home/home_screen.dart';
import 'package:mikipo/src/ui/home/viewmodel/home_view_model.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/viewmodel/state/registration_login_state.dart';
import 'package:mikipo/src/ui/splash/splash_screen.dart';
import 'package:mikipo/src/ui/waitbossacceptmembership/wait_boss_accept_membership.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  static final _logger = getLogger('AuthWidget');

  final AsyncSnapshot<User> userSnapshot;

  const AuthWidget({@required this.userSnapshot});

  final _splashScreen = const SplashScreen();
  final _loginScreen = const LoginScreen();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...${hashCode}');
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        final user = userSnapshot.data;
        if (!user.isEmailVerified) {
          return EmailNotVerified();
        } else if (!user.isAcceptedByChef) {
          return WaitBossAcceptMemberShip();
        } else {
          return _getHomeScreen(user);
        }
      } else {
        return _getLoginScreen();
      }
    }
    return _splashScreen;
  }

  Widget _getHomeScreen(User user) {
    final viewModel = serviceLocator<HomeViewModel>();
    _logger.d('Se ha creado el viewModel HomeViewModel con hash ${viewModel.hashCode}');
    return MultiProvider(
      builder: (_, __) => HomeScreen(viewModel, user),
      providers: [
        Provider<HomeViewModel>.value(value: viewModel),
        ChangeNotifierProvider<ValueNotifier<HomePage>>.value(
            value: viewModel.page),
      ],
    );
    //return HomeScreen(viewModel);
  }

  Widget _getLoginScreen() {
    final viewModel = serviceLocator<LoginViewModel>();
    _logger.d('Se ha creado el viewModel LoginViewModel con hash ${viewModel.hashCode}');
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
    );
  }
}
