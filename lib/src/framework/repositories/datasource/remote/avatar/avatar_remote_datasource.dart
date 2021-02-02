import 'dart:io';

abstract class IAvatarRemoteDatasource {

  Future<String> saveUserAvatar(String userId, File avatar);
}