import 'dart:io';

import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IUserLocalStorageDataSource {

  User getUser();

  Future<void> saveUser(User user);
  Future<void> updateUserData(Map<String,dynamic> data);
  Future<bool> deleteUser();
}