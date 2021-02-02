import 'dart:io';

import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';

class CropImageUseCase {

  final IAvatarRepository _avatarRepository;

  CropImageUseCase(this._avatarRepository);

  Future<File> call(File image) => _avatarRepository.cropImage(image);


}