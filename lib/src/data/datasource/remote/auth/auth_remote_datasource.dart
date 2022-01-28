import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class IAuthRemoteDatasource {
  Future<void> refreshUserToken(
      {@required String email, @required String pass});

  Stream<User> get firebaseUser;

  Future<String> registerUser({@required String email, @required String pass});
  Future<User> refreshUser();
  Future<User> loginUser({@required String email, @required String pass});

  Future<void> deleteUser();
  Future<void> logoutUser();

  bool get isUserAuthenticated;

  String get userId;

  Future<bool> get isEmailVerified;
}
