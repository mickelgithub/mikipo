import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';

abstract class AuthState {}

class AuthStateAuthenticated implements AuthState {
  final User user;
  AuthStateAuthenticated(this.user);
}

class AuthStateFailure implements AuthState {
  final Failure failure;
  AuthStateFailure(this.failure);
}