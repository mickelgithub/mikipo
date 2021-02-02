import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/domain/repository/auth/auth_repository.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/domain/repository/chef/chef_repository.dart';
import 'package:mikipo/src/domain/repository/notification/notification_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';
import 'package:mikipo/src/util/email/email_util.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/heigh_profile_extensions.dart';

class RegisterUserUseCase {

  static final _logger= getLogger((RegisterUserUseCase).toString());

  final IAuthRepository _authRepository;
  final IAvatarRepository _avatarRepository;
  final IUserRepository _userRepository;
  final IChefRepository _chefRepository;
  final INotificationRepository _notificationRepository;

  RegisterUserUseCase(this._authRepository, this._avatarRepository,
      this._userRepository, this._chefRepository, this._notificationRepository);

  Future<Failure> call({@required String email, @required String pass,
    File avatar= null, @required HeighProfile heighProfile,
    @required Section section, Area area= null, Department department= null}) async {

    //we have to see if the user is a chef and if there is already one on the system
    bool alreadyExist= false;
    if (heighProfile.isChef()) {
      final resultChefLookup= await _chefRepository.isChefAlreadyExists(User(section: section,
          area: area, department: department, heighProfile: heighProfile));
      if (resultChefLookup.isLeft()) {
        return InternetNotAvailable();
      } else {
        alreadyExist= await resultChefLookup.getOrElse(null);
      }
    }
    if (!alreadyExist) {
      final registerUserResult= await _authRepository.registerUser(email: email, pass: pass);
      return registerUserResult.fold((failure) {
        return failure;
      }, (userId) async {
        //User is registered OK, so we send the email verificacion
        String remoteAvatar;
        if (avatar!= null) {
          final saveAvatarResult= await _avatarRepository.saveAvatar(userId, avatar);
          File avatarCache= avatar;
          avatar= saveAvatarResult.value1;
          remoteAvatar= saveAvatarResult.value2;
          _logger.d('Ya hemos subido el avatar del usuario y la url es ${remoteAvatar}');
          await _avatarRepository.removeAvatarFromCache(avatarCache);
        }
        final List<String> fullName= EmailUtil.getNameAndSurname(email);
        final notificationKey= await _notificationRepository.token;

        await _userRepository.saveUser(User(
            pass: pass,
            email: email,
            remoteAvatar: remoteAvatar,
            avatar: avatar== null ? null : avatar.path,
            surname: fullName.length> 1 ? fullName[1] : null,
            name: fullName[0],
            id: userId,
            area: area,
            department: department,
            heighProfile: heighProfile,
            section: section,
            notificationKey: notificationKey,
            isEmailVerified: false,
            isAcceptedByChef: false,
            state: User.STATE_ACTIVE
        ));
        return null;
      });
    } else {
     return ChefAlreadyExists(User(section: section,
         area: area, department: department, heighProfile: heighProfile));
    }
  }

}