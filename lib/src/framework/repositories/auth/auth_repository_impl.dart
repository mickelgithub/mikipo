import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:mikipo/src/data/auth/auth_repository.dart';
import 'package:mikipo/src/domain/auth/user.dart';
import 'package:mikipo/src/domain/organization/area.dart';
import 'package:mikipo/src/domain/organization/department.dart';
import 'package:mikipo/src/domain/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/organization/section.dart';
import 'package:mikipo/src/framework/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/framework/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/framework/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';


class AuthRepositoryImpl implements IAuthRepository {

  final logger= getLogger('AuthRepositoryImpl');

  final IAuthRemoteDatasource _authRemoteDatasource;
  final IUserLocalStorageDataSource _userLocalStorageDataSource;
  final IAvatarRemoteDatasource _avatarRemoteDatasource;

  AuthRepositoryImpl(this._authRemoteDatasource, this._userLocalStorageDataSource, this._avatarRemoteDatasource);

  @override
  Stream<User> get user => _authRemoteDatasource.firebaseUser.transform(
    StreamTransformer.fromHandlers(handleData: (firebaseUser, sink) async {
      logger.d('Se ha ejecutado el stream de get user...${firebaseUser}');
      User localUser= _userLocalStorageDataSource.getUser();
       if (firebaseUser!= null) {
         //el usuario esta autentificado
         logger.d('El usuario esta autentificado y su id es ${firebaseUser.uid}');
         sink.add(localUser);
       } else {
         //El usuario no esta autentificado
         if (localUser== null) {
           //primera instalacion
           logger.d('primera instalacion...');
           sink.add(null);
         } else {
           logger.d('el usuario ya tiene la info en local, vamos a refrescar el token');
           await _authRemoteDatasource.refreshUserToken(localUser.email, localUser.pass);
           sink.add(localUser);
         }
       }
    }));

  @override
  Future<void> registerUser({String email, String pass, File avatar = null, HeighProfile heighProfile, Section section, Area area, Department department}) async {
    String name;
    String surname= '';
    final result= email.split('@');
    final fullName= result[0];
    if (fullName.contains('.')) {
      final fullNameList= fullName.split('.');
      name= fullNameList[0];
      surname= fullNameList[1];
    } else {
      name= fullName;
    }
    logger.d('vamos a registar el usuario ${email}');
    final userId= await _authRemoteDatasource.registerUser(email: email, pass: pass);
    logger.d('Ya se ha registrado el usuario ${email} y su id es ${userId}');
    String remoteAvatar;
    if (avatar!= null) {
      remoteAvatar= await _avatarRemoteDatasource.saveUserAvatar(userId, avatar);
      logger.d('Ya hemos subido el avatar del usuario y la url es ${remoteAvatar}');
    }
    await _userLocalStorageDataSource.saveUser(userId: userId, email: email, pass: pass, name: name, surname: surname, avatar: avatar, remoteAvatar: remoteAvatar);
  }

}