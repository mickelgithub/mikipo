import 'package:dartz/dartz.dart';
import 'package:mikipo/data/auth/auth_repository.dart';
import 'package:mikipo/domain/auth/user.dart';
import 'package:mikipo/domain/common/failure.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  Future<Either<Failure, User>> getAuthenticatedUser() async {
    print('Vamos a obtener el usuario autenficado');
    Future.delayed(Duration(seconds: 3), () {});
    return right(User(id: '123456789'));
  }



}