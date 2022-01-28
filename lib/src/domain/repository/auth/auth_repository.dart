import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/common/failure.dart';

abstract class IAuthRepository {

  Future<Either<AuthFailure, String>> registerUser(
      {@required String email, @required String pass});

  Future<Either<AuthFailure, String>> loginUser({String email, String pass});

  Future<Either<Failure,bool>> get isEmailVerified;

  bool get isUserAuthenticated;

  String get userId;

  void logout();


  //---------------------------Esto se borra

  Stream<User> get user;
}
