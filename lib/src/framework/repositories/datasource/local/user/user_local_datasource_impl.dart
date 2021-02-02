import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mikipo/src/domain/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_local_datasource.dart';

class UserLocalStorageDataSourceImpl extends IUserLocalStorageDataSource {

  final SharedPreferences _preferences;

  UserLocalStorageDataSourceImpl(@required this._preferences);

  @override
  User getUser() {
    String userId= _preferences.get(User.USER_ID);
    if (userId== null) {
      return null;
    } else {
      final String email= _preferences.getString(User.EMAIL);
      final String pass= _preferences.getString(User.PASS);
      final String avatar= _preferences.getString(User.AVATAR);
      return User(userId: userId, email: email, pass: pass, avatar: avatar);
    }
  }

  @override
  Future<void> saveUser({String userId, String email, String pass, String name, String surname= null, File avatar= null, String remoteAvatar= null}) async {
    await _preferences.setString(User.USER_ID, userId);
    await _preferences.setString(User.EMAIL, email);
    await _preferences.setString(User.PASS, pass);
    await _preferences.setString(User.NAME, name);
    if (surname!= null && surname.isNotEmpty) {
      await _preferences.setString(User.SURNAME, surname);
    }
    if (avatar!= null) {
      await _preferences.setString(User.SURNAME, avatar.path);
    }
    if (remoteAvatar!= null && remoteAvatar.isNotEmpty) {
      await _preferences.setString(User.REMOTE_AVATAR, remoteAvatar);
    }
  }

}