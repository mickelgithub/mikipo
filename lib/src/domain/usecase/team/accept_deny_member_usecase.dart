import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/repository/team/team_repository.dart';

class AcceptDenyMemberUseCase {
  final ITeamRepository _teamRepository;

  AcceptDenyMemberUseCase(this._teamRepository);

  Future<void> call(
          {@required User chef,
          @required User member,
          @required bool accept}) =>
      _teamRepository.acceptDenyMember(
          chef: chef, member: member, accept: accept);
}
