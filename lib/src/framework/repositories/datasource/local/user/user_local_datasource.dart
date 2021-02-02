import 'dart:io';

import 'package:mikipo/src/domain/auth/user.dart';

abstract class IUserLocalStorageDataSource {

  User getUser();

  Future<void> saveUser({String userId, String email, String pass, String name, String surname= null, File avatar= null, String remoteAvatar= null});
}