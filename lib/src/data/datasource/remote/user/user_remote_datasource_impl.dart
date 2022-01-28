import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/exception.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class UserRemoteStorageDataSourceImpl implements IUserRemoteStorageDataSource {

  static const String _USERS_COLLECTION = 'users';

  final FirebaseFirestore _firebaseFirestore;

  UserRemoteStorageDataSourceImpl(this._firebaseFirestore);

  @override
  Future<User> getUser({String userId, bool fromServer= true}) async {
    final userSnapshot = await _firebaseFirestore
        .collection(_USERS_COLLECTION)
        .doc(userId)
        .get(fromServer ? GetOptions(source: Source.server) : null);
    if (!userSnapshot.exists) {
      //inconsistencies
      throw CustomException(CustomCause.userNotFound);
    }
    return User.fromMap(userSnapshot.data());
  }

  @override
  Future<void> saveUser(User user) async {
    CollectionReference users =
        _firebaseFirestore.collection(_USERS_COLLECTION);
    await users.doc(user.id).set(user.toMap());
  }

  //*******************************************************************************************



  @override
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await _firebaseFirestore
        .collection(_USERS_COLLECTION)
        .doc(userId)
        .update(data);
  }

  @override
  Future<String> isAcceptedByChef(String userId) async {
    CollectionReference users =
        _firebaseFirestore.collection(_USERS_COLLECTION);
    final userMap =
        await users.doc(userId).get(GetOptions(source: Source.server));
    return (userMap[UserConstants.IS_ACCEPTED_BY_CHEF] as String);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firebaseFirestore.collection(_USERS_COLLECTION).doc(userId).delete();
  }

  @override
  Future<void> deleteData(String userId, List<String> dataKeys) async {
    if (dataKeys != null && dataKeys.isNotEmpty) {
      final data = dataKeys.fold<Map<String, dynamic>>({}, (prev, key) {
        prev[key] = FieldValue.delete();
        return prev;
      });
      await _firebaseFirestore
          .collection(_USERS_COLLECTION)
          .doc(userId)
          .update(data);
    }
  }
}
