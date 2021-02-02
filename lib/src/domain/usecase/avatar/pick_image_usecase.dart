import 'dart:io';

import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';

class PickImageUseCase {

  final IAvatarRepository _avatarRepository;

  PickImageUseCase(this._avatarRepository);

  Future<File> call(ImageSource source) => _avatarRepository.pickImage(source);



}