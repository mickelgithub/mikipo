import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';

class AuthFailure extends Failure {}

class EmailAlreadyInUse extends AuthFailure {}
class InternetNotAvailable extends AuthFailure {}
class AuthServerError extends AuthFailure {}
class ServerError extends AuthFailure {}
class TooManyLoginRequest extends AuthFailure {}
class WrongPasswordOnLogin extends AuthFailure {}
class UserNotFoundOnLogin extends AuthFailure {}
class UserNotFoundOnRemoteDatabase extends AuthFailure{}
class ChefAlreadyExists extends AuthFailure {
  final User user;
  ChefAlreadyExists(this.user);
}

