import 'package:mikipo/src/domain/repository/team/team_repository.dart';
import 'package:mikipo/src/domain/repository/user/user_repository.dart';

class HandleAcceptDenyMemberNotificationUseCase {
  final ITeamRepository _teamRepository;
  final IUserRepository _userRepository;

  HandleAcceptDenyMemberNotificationUseCase(
      this._teamRepository, this._userRepository);

  Future<void> call(bool accept) async {
    /*final localUser = await _userRepository.getUser();
    await _teamRepository.handleAcceptDenyMemberNotification(
        localUser.id, accept);*/
    return null;
  }
}
