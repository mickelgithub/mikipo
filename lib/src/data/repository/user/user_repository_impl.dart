import 'package:mikipo/src/data/datasource/local/user/user_local_datasource.dart';
import 'package:mikipo/src/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {

  final IUserLocalStorageDataSource _userLocalStorageDataSource;
  final IUserRemoteStorageDataSource _userRemoteStorageDataSource;

  UserRepositoryImpl(this._userLocalStorageDataSource, this._userRemoteStorageDataSource);

  @override
  Future<void> saveUser(User user) async {
    await _userRemoteStorageDataSource.saveUser(user);
    await _userLocalStorageDataSource.saveUser(user);
  }

}