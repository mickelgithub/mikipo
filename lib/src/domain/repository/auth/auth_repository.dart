import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IAuthRepository {
  
  Stream<User> get user;

  Future<Either<AuthFailure, String>> registerUser({@required String email, @required String pass});

  Future<Either<AuthFailure, String>> loginUser({String email, String pass});

}