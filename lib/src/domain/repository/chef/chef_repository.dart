import 'package:dartz/dartz.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class IChefRepository {
  Future<Either<AuthFailure, bool>> isChefAlreadyExists(User user);
  Future<Either<AuthFailure, User>> getMyChef(User user);
  Future<void> addChef(User user);
}
