import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/constants/type_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorageDataSourceImpl extends IUserLocalStorageDataSource {

  final SharedPreferences _preferences;

  UserLocalStorageDataSourceImpl(@required this._preferences);

  @override
  User getUser() {
    String userId= _preferences.get(User.USER_ID);
    if (userId== null) {
      return null;
    } else {
      final email= _preferences.getString(User.EMAIL);
      final pass= _preferences.getString(User.PASS);
      final avatar= _preferences.getString(User.AVATAR);
      final remoteAvatar= _preferences.getString(User.REMOTE_AVATAR);
      final name= _preferences.getString(User.NAME);
      final surname= _preferences.getString(User.SURNAME);
      final isEmailVerified= _preferences.getBool(User.IS_EMAIL_VERIFIED);
      final notificationKey= _preferences.getString(User.NOTIFICATION_KEY);
      final isAcceptedByChef= _preferences.getBool(User.IS_ACCEPTED_BY_CHEF);
      final state= _preferences.getString(User.STATE);
      final heighProfile= HeighProfile(
        id: _preferences.getInt(HeighProfile.ID),
        name: _preferences.getString(HeighProfile.NAME),
        level: _preferences.getInt(HeighProfile.LEVEL)
      );
      final section= Section(
        id: _preferences.getInt(Section.ID),
        name: _preferences.getString(Section.NAME),
        icon: _preferences.getString(Section.ICON)
      );
      final area= _preferences.getInt(Area.ID)== null ? null : Area(
        id: _preferences.getInt(Area.ID),
        name: _preferences.getString(Area.NAME),
        icon: _preferences.getString(Area.ICON)
      );
      final department= _preferences.getInt(Department.ID)== null ? null : Department(
        id: _preferences.getInt(Department.ID),
        name: _preferences.getString(Department.NAME)
      );
      return User(id: userId, email: email, pass: pass, avatar: avatar,
          remoteAvatar: remoteAvatar, name: name, surname: surname,
          isEmailVerified: isEmailVerified, isAcceptedByChef: isAcceptedByChef,
          section: section, state: state, area: area, department: department,
          heighProfile: heighProfile, notificationKey: notificationKey);
    }
  }

  @override
  Future<void> saveUser(User user) async {
    await _preferences.setString(User.USER_ID, user.id);
    await _preferences.setString(User.EMAIL, user.email);
    await _preferences.setString(User.PASS, user.pass);
    await _preferences.setString(User.NAME, user.name);
    if (user.surname!= null && user.surname.isNotEmpty) {
      await _preferences.setString(User.SURNAME, user.surname);
    }
    if (user.avatar!= null && user.avatar.isNotEmpty) {
      await _preferences.setString(User.AVATAR, user.avatar);
    }
    if (user.remoteAvatar!= null && user.remoteAvatar.isNotEmpty) {
      await _preferences.setString(User.REMOTE_AVATAR, user.remoteAvatar);
    }
    await _preferences.setBool(User.IS_EMAIL_VERIFIED, user.isEmailVerified);
    await _preferences.setString(User.NOTIFICATION_KEY, user.notificationKey);
    await _preferences.setString(User.STATE, user.state);
    await _preferences.setBool(User.IS_ACCEPTED_BY_CHEF, user.isAcceptedByChef);
    //heighProfile
    await _preferences.setInt(HeighProfile.ID, user.heighProfile.id);
    await _preferences.setString(HeighProfile.NAME, user.heighProfile.name);
    await _preferences.setInt(HeighProfile.LEVEL, user.heighProfile.level);
    //section
    await _preferences.setInt(Section.ID, user.section.id);
    await _preferences.setString(Section.NAME, user.section.name);
    await _preferences.setString(Section.ICON, user.section.icon);
    //area
    if (user.area!= null) {
      await _preferences.setInt(Area.ID, user.area.id);
      await _preferences.setString(Area.NAME, user.area.name);
      await _preferences.setString(Area.ICON, user.area.icon);
    }
    //department
    if (user.department!= null) {
      await _preferences.setInt(Department.ID, user.department.id);
      await _preferences.setString(Department.NAME, user.department.name);
    }
  }

  @override
  Future<void> updateUserData(Map<String,dynamic> data) async {
    data.keys.forEach((key) async {
      if (data[key].runtimeType.toString()== TypeConstants.INT) {
        await _preferences.setInt(key, data[key] as int);
      } else if (data[key].runtimeType.toString()== TypeConstants.STRING) {
        await _preferences.setString(key, data[key] as String);
      } else if (data[key].runtimeType.toString()== TypeConstants.DOUBLE) {
        await _preferences.setDouble(key, data[key] as double);
      } else if (data[key].runtimeType.toString()== TypeConstants.BOOLEAN) {
        await _preferences.setBool(key, data[key] as bool);
      } else {
        throw Exception('');
      }
    });
  }

  @override
  Future<bool> deleteUser() async {
    return await _preferences.clear();
  }

}