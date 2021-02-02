import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IUserRepository {

  Future<void> saveUser(User user);

}