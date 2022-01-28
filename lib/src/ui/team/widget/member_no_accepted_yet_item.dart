import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/team/viewmodel/team_view_model.dart';
import 'package:mikipo/src/util/extensions/user_extensions.dart';
import 'package:provider/provider.dart';

class MemberNotAcceptedYetItem extends StatefulWidget {
  final User chef;
  final User member;

  const MemberNotAcceptedYetItem({@required this.member, @required this.chef});

  @override
  _MemberNotAcceptedYetItemState createState() =>
      _MemberNotAcceptedYetItemState();
}

class _MemberNotAcceptedYetItemState extends State<MemberNotAcceptedYetItem> {
  bool acceptClicked = false;
  bool denyClicked = false;

  @override
  Widget build(BuildContext context) {
    TeamViewModel viewModel =
        Provider.of<TeamViewModel>(context, listen: false);

    String initials = widget.member.name.substring(0, 1).toUpperCase();
    if (widget.member.surname != null && widget.member.surname.isNotEmpty) {
      initials =
          '$initials${widget.member.surname.substring(0, 1).toUpperCase()}';
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: widget.member.hasRemoteAvatar()
              ? NetworkImage(widget.member.remoteAvatar)
              : null,
          backgroundColor: widget.member.hasRemoteAvatar() ? null : Colors.blue,
          child: widget.member.hasRemoteAvatar() ? null : Text(initials),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.member.fullName()}',
            ),
            SizedBox(
              height: 32.0,
            )
          ],
        ),
        Spacer(),
        TweenAnimationBuilder(
          duration: const Duration(),
          tween: Tween(begin: 1.0, end: acceptClicked ? 0.0 : 1.0),
          builder: (BuildContext context, dynamic value, Widget child) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: value,
              child: TextButton(
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightGreen[700],
                ),
                onPressed: () {
                  viewModel.accept(chef: widget.chef, member: widget.member);
                  setState(() {
                    acceptClicked = true;
                  });
                },
              ),
            );
          },
        ),
        SizedBox(
          width: 8.0,
        ),
        TextButton(
          child: Text(
            'Denegar',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Palette.ldaColor,
          ),
          onPressed: () {
            viewModel.deny(chef: widget.chef, member: widget.member);
          },
        ),
      ],
    );
  }
}
