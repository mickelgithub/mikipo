import 'dart:io';

import 'package:dartz/dartz.dart';

enum ImageSource { gallery, camera }

abstract class IAvatarRepository {

  Future<File> pickImage(ImageSource source);
  Future<void> removeAvatarFromCache(File avatar);
  Future<File> cropImage(File image);
  Future<Tuple2<File,String>> saveAvatar(String userId, File avatar);
  Future<void> removeAvatar();


}