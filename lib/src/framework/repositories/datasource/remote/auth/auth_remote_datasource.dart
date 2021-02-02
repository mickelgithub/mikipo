import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRemoteDatasource {

  void refreshUserToken(String email, String pass);

  Stream<User> get firebaseUser;

  Future<String> registerUser({String email, String pass});

}