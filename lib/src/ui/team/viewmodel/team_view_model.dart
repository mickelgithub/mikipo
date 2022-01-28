import 'package:mikipo/src/domain/usecase/team/accept_deny_member_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/get_team_members_usecase.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:flutter/foundation.dart';

class TeamViewModel with ChangeNotifier {
  final GetTeamMembersUseCase _getTeamMembersUseCase;
  final AcceptDenyMemberUseCase _acceptDenyMemberUseCase;

  TeamViewModel(this._getTeamMembersUseCase, this._acceptDenyMemberUseCase);

  List<User> members;

  User _user;
  User get user => _user;

  void init(User user) async {
    this._user= user;
    members = await _getTeamMembers(user);
  }

  Future<List<User>> _getTeamMembers(User user) async {
    return await _getTeamMembersUseCase(user);
  }

  //the chef has accepted a member
  void accept({@required User chef, @required User member}) async {
    await _acceptDenyMemberUseCase(chef: chef, member: member, accept: true);
    /*List<User> users = [...members.value];
    final memberAccepted =
        member.copyWith(isAcceptedByChef: StringConstants.YES);
    final index = users.indexOf(member);
    users.insert(index, memberAccepted);
    users.removeAt(index + 1);
    members.value = users;*/
  }

  //the chef has denied a member
  void deny({@required User chef, @required User member}) async {
    await _acceptDenyMemberUseCase(chef: chef, member: member, accept: false);
  }
}
