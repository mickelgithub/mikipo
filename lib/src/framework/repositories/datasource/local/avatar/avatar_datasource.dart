import 'dart:io';

abstract class IAvatarLocalDatasource {

  Future<File> pickImageFromGallery();
  Future<File> pickImageFromCamera();
  Future<File> cropImage(File image);

}