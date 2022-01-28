import 'package:meta/meta.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class ITeamRepository {
  Future<List<User>> getTeamMembers(User user);

  Future<void> acceptDenyMember(
      {@required User chef, @required User member, @required bool accept});

  Future<void> handleAcceptDenyMemberNotification(String userId, bool accept);
}
