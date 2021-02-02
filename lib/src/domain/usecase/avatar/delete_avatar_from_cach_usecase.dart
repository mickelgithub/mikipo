import 'dart:io';

import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';

class DeleteAvatarFromCacheUserCase {

  final IAvatarRepository _avatarRepository;

  DeleteAvatarFromCacheUserCase(this._avatarRepository);

  Future<void> call(File avatar) => _avatarRepository.removeAvatarFromCache(avatar);

}