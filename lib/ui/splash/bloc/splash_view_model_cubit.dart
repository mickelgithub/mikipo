import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/data/auth/auth_repository.dart';
import 'package:mikipo/domain/auth/user.dart';
import 'package:mikipo/domain/common/failure.dart';

part 'splash_view_model_state.dart';

class SplashViewModel extends Cubit<SplashViewModelState> {

  final AuthRepository _authRepository;

  SplashViewModel(this._authRepository) : super(SplashViewModelInitial());

  Future<void> getAuthenticatedUser() async {
      final result= await _authRepository.getAuthenticatedUser();
      result.fold((failure) {
        print("An exception has ocurred:${failure.message}...go to login UI");
        emit(SplashViewModelNotAuthenticated());
      }, (user) {
        if (user== User.notAuthenticatedUser) {
          print("user not authenticated...go to login UI");
          emit(SplashViewModelNotAuthenticated());
        } else {
          print("user ${user.id} is loggedIn...go to home UI");
          emit(SplashViewModelAuthenticated(user));
        }
      });
  }
}
