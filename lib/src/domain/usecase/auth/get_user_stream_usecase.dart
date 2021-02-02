import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';

class GetUserStreamUseCase {

  final IAuthRepository _authRepository;

  GetUserStreamUseCase(this._authRepository);

  Stream<User> call() => _authRepository.user;

}