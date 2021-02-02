import 'package:mikipo/src/domain/usecase/team/accept_deny_member_usecase.dart';
import 'package:mikipo/src/domain/usecase/team/get_team_members_usecase.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:flutter/foundation.dart';


class TeamViewModel {

  final GetTeamMembersUseCase _getTeamMembersUseCase;
  final AcceptDenyMemberUseCase _acceptDenyMemberUseCase;

  TeamViewModel(this._getTeamMembersUseCase, this._acceptDenyMemberUseCase);

  ValueNotifier<List<User>> members= ValueNotifier(null);

  void init(User user) async {
    //members.value= members.value!= null ? members.value : await _getTeamMembers(user);
    members= ValueNotifier(null);
    members.value= await _getTeamMembers(user);
    print('hola');
  }


  Future<List<User>> _getTeamMembers(User user) async {
    return await _getTeamMembersUseCase(user);
  }

  //the chef has accepted a member
  void accept({@required User chef, @required User member}) async {
    await _acceptDenyMemberUseCase(chef: chef, member: member);
  }

  //the chef has denied a member
  void deny({@required User chef, @required User member}) {
    print('deny....');
  }

}