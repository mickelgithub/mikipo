import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mikipo/framework/auth/auth_repository_impl.dart';
import 'package:mikipo/ui/comun/colors.dart';

import 'bloc/splash_view_model_cubit.dart';

class SplashScreen extends StatelessWidget {

  SplashViewModel _viewModel;

  SplashScreen() {
    _viewModel= SplashViewModel(AuthRepositoryImpl());
    _viewModel.getAuthenticatedUser();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashViewModel,SplashViewModelState>(
      cubit: _viewModel,
      builder: (BuildContext _, __) => Scaffold(
        backgroundColor: Palette.SplashBackgroudColor,
        body: Center(
          child: Container(
            height: 100,
            width: 100,
            color: Palette.SplashBackgroudColor,
            child: Image.asset('assets/images/team.png'),
          ),
        ),
      ),
      listener: (BuildContext context, state) {
        _handleState(state, context);
      },
    );
  }

  _handleState(SplashViewModelState state, BuildContext context) {
    if (state is SplashViewModelAuthenticated) {
      print("the user is autenticated ${state.user.id}");
      Navigator.of(context).pushReplacementNamed('/login');
    } else if (state is SplashViewModelNotAuthenticated) {
      print("The user is not authenticated...");
    }
  }
}
