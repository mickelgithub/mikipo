import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/local/local_state_info.dart';

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
class UserDischarged extends AuthFailure {}
class UserDisabled extends AuthFailure {}
class UserEmailNotVerifiedYet extends AuthFailure {}
class UserNotAuthenticatedButNotNew extends AuthFailure {
  final LocalStateInfo localStateInfo;
  UserNotAuthenticatedButNotNew(this.localStateInfo);
}
class UserNotAuthenticatedNewInstalation extends AuthFailure {}

