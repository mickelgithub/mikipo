import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dartz/dartz.dart';
import 'package:mikipo/src/data/datasource/remote/chef/chef_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/chef/chef_repository.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class ChefRepositoryImpl implements IChefRepository {
  static final _logger = getLogger((ChefRepositoryImpl).toString());

  //static const String _UNKNOWN_ERROR= 'unknown';
  static const String _UNAVAILABLE = 'unavailable';

  final IChefRemoteStorageDataSource _chefRemoteStorageDataSource;

  ChefRepositoryImpl(this._chefRemoteStorageDataSource);

  @override
  Future<Either<AuthFailure, bool>> isChefAlreadyExists(User user) async {
    try {
      return right(
          await _chefRemoteStorageDataSource.isChefAlreadyExists(user));
    } on firestore.FirebaseException catch (e) {
      _logger.e(e);
      if (e.code == _UNAVAILABLE) {
        return left(InternetNotAvailable());
      } else {
        return left(ServerError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, User>> getMyChef(User user) async {
    try {
      return right(await _chefRemoteStorageDataSource.getMyChef(user));
    } on firestore.FirebaseException catch (e) {
      _logger.e(e);
      if (e.code == _UNAVAILABLE) {
        return left(InternetNotAvailable());
      } else {
        return left(ServerError());
      }
    }
  }

  @override
  Future<void> addChef(User user) async {
    return await _chefRemoteStorageDataSource.addChef(user);
  }
}
