import 'dart:io';

abstract class IAvatarLocalDatasource {
  Future<File> pickImageFromGallery();
  Future<File> pickImageFromCamera();
  Future<File> cropImage(File image);
  Future<File> saveImage(File image);
  Future<void> removeImage(File image);
  Future<File> getFileForAvatar(String extension);
  Future<void> removeAvatar();
}
