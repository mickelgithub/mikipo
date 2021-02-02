import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mikipo/src/framework/datasource/remote/avatar/avatar_remote_datasource.dart';

class AvatarRemoteDatasourceImpl implements IAvatarRemoteDatasource {

  final FirebaseStorage _firebaseStorage;

  AvatarRemoteDatasourceImpl(this._firebaseStorage);

  @override
  Future<String> saveUserAvatar(String userId, File avatar) async {

    final reference= _firebaseStorage.ref('avatars').child(userId);
    final uploadTask= await reference.putFile(avatar);
    return await uploadTask.ref.getDownloadURL();

  }

}