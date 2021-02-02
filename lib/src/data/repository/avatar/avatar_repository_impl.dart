import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';


class AvatarRepositoryImpl implements IAvatarRepository {

  final IAvatarLocalDatasource _avatarLocalDatasource;
  final IAvatarRemoteDatasource _avatarRemoteDatasource;

  AvatarRepositoryImpl(this._avatarLocalDatasource, this._avatarRemoteDatasource);

  @override
  Future<File> pickImage(ImageSource source) async => source== ImageSource.gallery ? await _avatarLocalDatasource.pickImageFromGallery() : await _avatarLocalDatasource.pickImageFromCamera();

  @override
  Future<void> removeAvatarFromCache(File avatar) async {
    await _avatarLocalDatasource.removeImage(avatar);
  }

  @override
  Future<File> cropImage(File image) {
    return _avatarLocalDatasource.cropImage(image);
  }

  @override
  Future<Tuple2<File,String>> saveAvatar(String userId, File avatar) async {
    final localAvatar= await _avatarLocalDatasource.saveImage(avatar);
    String remoteAvatar= await _avatarRemoteDatasource.saveAvatar(userId, localAvatar);
    return Tuple2(localAvatar, remoteAvatar);
  }

  @override
  Future<void> removeAvatar() async {
    await _avatarLocalDatasource.removeAvatar();
  }

}