import 'package:flutter/material.dart';
import 'package:mikipo/ui/login/login_screen.dart';
import 'package:mikipo/ui/splash/bloc/splash_view_model.dart';
import 'package:mikipo/ui/splash/splash_screen.dart';


class AuthWidget extends StatelessWidget {

  final SplashViewModel _splashViewModel;

  const AuthWidget(this._splashViewModel);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SplashViewModelState>(
        future: _splashViewModel.getAuthenticatedUser(),
        initialData: SplashViewModelStateInProcess(),
        builder: (context, snapshot) {
          print(snapshot);
          Widget _result= LoginScreen();
          print('${snapshot.error}:${snapshot.data}:${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data is SplashViewModelStateAuthenticated) {
                print('el usuario esta autenticado y su id es ${(snapshot
                    .data as SplashViewModelStateAuthenticated).user.id}');
              } else if (snapshot.data is SplashViewModelStateNotAuthenticated) {
                print('El usuario no esta autenticado....');
              } else if (snapshot.data is SplashViewModelStateFailure) {
                print('Hubo error:${(snapshot.data as SplashViewModelStateFailure).failure.message}');
              }
            } else {
              //hubo algun error
              print('Hubo el siguiente error:${snapshot.error}');
            }
          } else {
            print(
                "Estamos a la espera de saber el estado de autenticacion, mostramos el splashScreen...");
            _result= SplashScreen();
          }
          return _result;
        },);

  }
}
