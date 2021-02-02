import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class ITeamRemoteDatasource {

  Future<List<User>> getTeamMembers(User user);
}