import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class IAuthRemoteDatasource {

  void refreshUserToken({@required String email, @required String pass});

  Stream<User> get firebaseUser;

  Future<String> registerUser({@required String email, @required String pass});
  Future<User> refreshUser();
  Future<User> loginUser({@required String email, @required String pass});

}