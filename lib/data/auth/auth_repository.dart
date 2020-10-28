import 'package:dartz/dartz.dart';
import 'package:mikipo/domain/auth/user.dart';
import 'package:mikipo/domain/common/failure.dart';

abstract class AuthRepository {

  Future<Either<Failure, User>> getAuthenticatedUser();

}