import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/data/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class AuthRemoteDatasourceImpl implements IAuthRemoteDatasource {
  static final _logger = getLogger((AuthRemoteDatasourceImpl).toString());

  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourceImpl(this._firebaseAuth);

  @override
  Future<void> refreshUserToken(
      {@required String email, @required String pass}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  @override
  Stream<User> get firebaseUser {
    _logger.d(
        '$hashCode +++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    return _firebaseAuth.authStateChanges();
  }

  @override
  Future<String> registerUser(
      {@required String email, @required String pass}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
    await _firebaseAuth.currentUser.sendEmailVerification();
    return userCredential.user.uid;
  }

  @override
  Future<User> refreshUser() async {
    await _firebaseAuth.currentUser.reload();
    return _firebaseAuth.currentUser;
  }

  @override
  Future<User> loginUser(
      {@required String email, @required String pass}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
    return userCredential.user;
  }

  @override
  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser.delete();
  }

  @override
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }

  @override
  bool get isUserAuthenticated => _firebaseAuth.currentUser != null;

  @override
  String get userId => _firebaseAuth.currentUser.uid;

  @override
  Future<bool> get isEmailVerified async {
    if (!_firebaseAuth.currentUser.emailVerified) {
      await _firebaseAuth.currentUser.reload();
    }
    return _firebaseAuth.currentUser.emailVerified;
  }
}
