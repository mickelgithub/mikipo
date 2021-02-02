import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/exception.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class UserRemoteStorageDataSourceImpl implements IUserRemoteStorageDataSource {

  static const String USER_NOT_FOUND= 'user-not-found';
  static const String _USERS_COLLECTION= 'users';

  final FirebaseFirestore _firebaseFirestore;

  UserRemoteStorageDataSourceImpl(this._firebaseFirestore);

  @override
  Future<void> saveUser(User user) async {

    CollectionReference users = _firebaseFirestore.collection(_USERS_COLLECTION);
    await users.doc(user.id).set(user.toMap());

  }

  @override
  Future<User> getUser(String userId) async {
    final userSnapshot= await _firebaseFirestore.collection(_USERS_COLLECTION).doc(userId).get();
    if (!userSnapshot.exists) {
      //inconsistencies
      throw CustomException(USER_NOT_FOUND);
    }
    return User.fromMap(userSnapshot.data());
  }

  @override
  Future<void> updateUserData(String userId, Map<String,dynamic> data) async {
    await _firebaseFirestore.collection(_USERS_COLLECTION).doc(userId).update(data);
  }

  @override
  Future<bool> isAcceptedByChef(String userId) async {
    CollectionReference users = _firebaseFirestore.collection(_USERS_COLLECTION);
    final userMap= await users.doc(userId).get(GetOptions(source: Source.server));
    return (userMap[User.IS_ACCEPTED_BY_CHEF] as bool);
  }

}