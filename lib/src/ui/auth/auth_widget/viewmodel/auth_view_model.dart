import 'package:mikipo/src/domain/usecase/auth/get_user_authentication_state_usecase.dart';
import 'package:mikipo/src/ui/auth/auth_widget/viewmodel/state/auth_state.dart';

class AuthViewModel {
  Future<AuthState> authStateFuture;

  final GetUserAuthenticationStateUseCase _getUserAuthenticationStateUseCase;

  AuthViewModel(this._getUserAuthenticationStateUseCase);

  /*Future<AuthState> getUserAuthState() async {
    return _getUserAuthenticationStateUseCase();
  }

  void init() {
    authStateFuture = getUserAuthState();
  }*/
}
