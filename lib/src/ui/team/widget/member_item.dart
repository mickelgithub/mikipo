import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';

class MemberItem extends StatelessWidget {

  final User chef;
  final User member;

  const MemberItem({@required this.member, @required this.chef});

  @override
  Widget build(BuildContext context) {

    TeamViewModel viewModel =
    Provider.of<TeamViewModel>(context, listen: false);

    String initials = member.name.substring(0, 1).toUpperCase();
    if (member.surname != null && member.surname.isNotEmpty) {
      initials = '${initials}${member.surname.substring(0, 1).toUpperCase()}';
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:
          member.hasRemoteAvatar() ? NetworkImage(member.remoteAvatar) : null,
          backgroundColor: member.hasRemoteAvatar() ? null : Colors.blue,
          child: member.hasRemoteAvatar() ? null : Text(initials),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${member.fullName()}',
            ),
            SizedBox(height: 32.0,)
          ],
        ),
        Spacer(),
      ],
    );
  }

}
