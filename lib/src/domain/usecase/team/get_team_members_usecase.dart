import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/team/team_repository.dart';

class GetTeamMembersUseCase {

  final ITeamRepository _teamRepository;

  GetTeamMembersUseCase(this._teamRepository);

  Future<List<User>> call(User user) => _teamRepository.getTeamMembers(user);

}