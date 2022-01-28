import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/local/local_state_info.dart';

abstract class AuthState {}

class AuthStateAuthenticated implements AuthState {
  final User user;
  AuthStateAuthenticated(this.user);
}

class AuthStateNotAuthenticatedNewInstalation implements AuthState {}

class AuthStateFailure implements AuthState {
  final Failure failure;
  AuthStateFailure(this.failure);
}

class AuthStateNotAuthenticatedButNotNew implements AuthState {
  final LocalStateInfo localStateInfo;
  AuthStateNotAuthenticatedButNotNew(this.localStateInfo);
}

class AuthStateNotAuthenticatedBiometricEnabled implements AuthState {
  final LocalStateInfo localStateInfo;
  AuthStateNotAuthenticatedBiometricEnabled(this.localStateInfo);
}

class AuthStateNotAuthenticatedSavedCredentials implements AuthState {
  final LocalStateInfo localStateInfo;
  AuthStateNotAuthenticatedSavedCredentials(this.localStateInfo);
}