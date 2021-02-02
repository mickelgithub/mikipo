import 'dart:io';

import 'package:mikipo/src/data/avatar/avatar_repository.dart';
import 'package:mikipo/src/framework/datasource/local/avatar/avatar_datasource.dart';

class AvatarRepositoryImpl implements IAvatarRepository {

  final IAvatarLocalDatasource avatarLocalDatasource;

  AvatarRepositoryImpl(this.avatarLocalDatasource);

  @override
  Future<File> pickImage(ImageSource source) async => source== ImageSource.gallery ? await avatarLocalDatasource.pickImageFromGallery() : await avatarLocalDatasource.pickImageFromCamera();

  @override
  Future<void> removeAvatarFromCache(File avatar) async {
    await avatar.delete();
  }

  @override
  Future<File> cropImage(File image) {
    return avatarLocalDatasource.cropImage(image);
  }

}