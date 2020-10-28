part of 'splash_view_model_cubit.dart';

@immutable
abstract class SplashViewModelState {}

class SplashViewModelInitial extends SplashViewModelState {}

class SplashViewModelAuthenticated extends SplashViewModelState {
  final User user;
  SplashViewModelAuthenticated(this.user);
}

class SplashViewModelNotAuthenticated extends SplashViewModelState {}

class SplashViewModelFailure extends SplashViewModelState {
  final Failure failure;
  SplashViewModelFailure(this.failure);
}

