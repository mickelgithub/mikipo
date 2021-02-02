import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mikipo/src/data/datasource/remote/avatar/avatar_remote_datasource.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/extensions/string_extensions.dart';

class AvatarRemoteDatasourceImpl implements IAvatarRemoteDatasource {

  static final _logger= getLogger((AvatarRemoteDatasourceImpl).toString());

  static const String _AVATAR_NAME= 'avatar';
  static const String _AVATAR_DIRECTORY= 'avatar';

  final FirebaseStorage _firebaseStorage;

  AvatarRemoteDatasourceImpl(this._firebaseStorage);

  @override
  Future<String> saveAvatar(String userId, File avatar) async {

    final reference= _firebaseStorage.ref(userId).child(_AVATAR_DIRECTORY).child('${_AVATAR_NAME}${avatar.path.extension}');
    final uploadTask= await reference.putFile(avatar);
    return await uploadTask.ref.getDownloadURL();

  }

  @override
  Future<Tuple2<bool,String>> downloadAvatar(String userId, File fileDestination) async {
    try {
      final result = await _firebaseStorage.ref(userId)
          .child(_AVATAR_DIRECTORY)
          .listAll();
      if (result.items.isNotEmpty) {
        await result.items.first.writeToFile(fileDestination);
        String url= await result.items.first.getDownloadURL();
        return Tuple2(true, url);
      }
    } catch (e) {
      _logger.e(e);
    }
    return Tuple2(false, null);
  }

}