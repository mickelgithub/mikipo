import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IUserRemoteStorageDataSource {

  Future<void> saveUser(User user);

  Future<User> getUser(String userId);

  Future<void> updateUserData(String userId, Map<String,dynamic> data);

  Future<bool> isAcceptedByChef(String userId);



}