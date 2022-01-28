import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetUserStreamUseCase {
  //stream that let us from other components to comunicate with
  //AuthBuilderWidget to refresh the screen, its usefull en first steps
  //of the registration
  final BehaviorSubject<User> _userController = BehaviorSubject<User>();

  final IAuthRepository _authRepository;

  GetUserStreamUseCase(this._authRepository);

  Stream<User> call() =>
      _userController.stream.mergeWith([_authRepository.user]);

  void updateUser(User user) {
    _userController.add(user);
  }

  void dispose() {
    _userController.close();
  }
}
