import 'package:mikipo/src/domain/entity/auth/user.dart';

abstract class ITeamRepository {

  Future<List<User>> getTeamMembers(User user);

  Future<void> acceptDenyMember({User chef, User member, bool accept});

  Future<void> handleAcceptDenyMemberNotification(bool accept);

}