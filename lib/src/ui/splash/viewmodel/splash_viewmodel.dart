import 'package:flutter/foundation.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/usecase/auth/get_user_authentication_state_usecase.dart';
import 'package:mikipo/src/ui/splash/state/auth_state.dart';

class SplashViewModel extends ChangeNotifier {

  final GetUserAuthenticationStateUseCase _getUserAuthenticationStatusUseCase;

  SplashViewModel(this._getUserAuthenticationStatusUseCase);

  Future<AuthState> getAuthState() async {
    final result= await _getUserAuthenticationStatusUseCase();
    return result.fold((l) {
      //InternetNotAvailable(),ServerError(),AuthServerError(),UserNotFoundOnRemoteDatabase()
      //UserDischarged(),UserDisabled()
      //UserNotAuthenticatedButNotNew
      //UserNotAuthenticatedNewInstalation
      //UserNotAuthenticated
      if (l is UserNotAuthenticatedButNotNew) {
        if (l.localStateInfo.biometricAuth) {
          return AuthStateNotAuthenticatedBiometricEnabled(l.localStateInfo);
        } else if (l.localStateInfo.savedCredentials) {
          return AuthStateNotAuthenticatedSavedCredentials(l.localStateInfo);
        }
        return AuthStateNotAuthenticatedButNotNew(l.localStateInfo);
      } else if (l is UserNotAuthenticatedNewInstalation) {
        return AuthStateNotAuthenticatedNewInstalation();
      }
      return AuthStateFailure(l);
    }, (r) {
      return AuthStateAuthenticated(r);
    });
  }

}