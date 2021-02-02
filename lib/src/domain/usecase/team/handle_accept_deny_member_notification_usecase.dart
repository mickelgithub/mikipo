import 'package:mikipo/src/domain/repository/team/team_repository.dart';

class HandleAcceptDenyMemberNotificationUseCase {

  final ITeamRepository _teamRepository;

  HandleAcceptDenyMemberNotificationUseCase(this._teamRepository);

  Future<void> call(bool accept) async => await _teamRepository.handleAcceptDenyMemberNotification(accept);

}