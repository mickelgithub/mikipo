import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class LoginUserUseCase {

  static final _logger= getLogger((LoginUserUseCase).toString());

  final IAuthRepository _authRepository;
  final IAvatarRepository _avatarRepository;
  final IUserRepository _userRepository;

  LoginUserUseCase(this._authRepository, this._avatarRepository, this._userRepository);

  Future<Failure> call({@required String email, @required String pass}) async {
    final loginUserResult= await _authRepository.loginUser(email: email, pass: pass);
    return loginUserResult.fold((failure) {
      return failure;
    }, (userId) {
      return null;
    });
  }
}