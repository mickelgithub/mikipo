import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IChefRemoteStorageDataSource {

  Future<bool> isChefAlreadyExists(User user);

  Future<User> getMyChef(User user);
  
}