import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IUserRemoteStorageDataSource {

  Future<void> saveUser(User user);

  Future<User> getUser({String userId, bool fromServer});

  Future<void> updateUserData(String userId, Map<String, dynamic> data);

  Future<String> isAcceptedByChef(String userId);

  Future<void> deleteUser(String userId);

  Future<void> deleteData(String userId, List<String> dataKeys);
}
