import 'package:firebase_auth/firebase_auth.dart';
import 'package:mikipo/src/framework/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class AuthRemoteDatasourceImpl implements IAuthRemoteDatasource {

  final logger= getLogger('AuthRemoteDatasourceImpl');

  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourceImpl(this._firebaseAuth);

  @override
  void refreshUserToken(String email, String pass) async {
    print('refreshUserToken ${email}:${pass}');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.d('No existe el usuario!!!');
      } else if (e.code == 'wrong-password') {
        logger.d('Contraseña incorrecta');
      }
    }
  }

  @override
  Stream<User> get firebaseUser => _firebaseAuth.authStateChanges();

  @override
  Future<String> registerUser({String email, String pass}) async {
    try {
      final userCredential= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential.user.uid;
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

}