import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatelessWidget {

  static final _logger= getLogger((AvatarWidget).toString());

  final VoidCallback onAvatarClick;

  const AvatarWidget({Key key, @required this.onAvatarClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    final size = MediaQuery.of(context).size;
    double topBackHeight = size.height * HEADER_HEIGHT_FACTOR;

    return Consumer3<ValueNotifier<LoginLogupAction>,
        ValueNotifier<KeyBoardState>, ValueNotifier<File>>(
      builder: (context, action, keyboardState, avatar, _) {

        double translation = topBackHeight -
            FORM_OFFSET_UP -
            AVATAR_SIZE / 2 -
            (keyboardState.value == KeyBoardState.opened ? FORM_TRANSLATION_Y : 0.0);
        return AnimatedPositioned(
          duration: Duration(milliseconds: ANIM_DURATION),
          top: translation,
          left: (size.width - AVATAR_SIZE) / 2,
          child: action.value== LoginLogupAction.login ? _getAvatarForLogin(avatar.value) : _getAvatarForLogup(avatar.value, onAvatarClick),
        );
      },
    );
  }

  Widget _getAvatarForLogup(File avatar, VoidCallback onAvatarClick) {
    return Stack(children: [
      Container(
        width: AVATAR_SIZE,
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            shape: BoxShape.circle,
            border: avatar == null
                ? Border.all(color: Palette.penelopeColor, width: 3)
                : Border.all(width: 3, color: Palette.white),
            boxShadow: [
              BoxShadow(
                color: Palette.black.withOpacity(0.5),
                offset: Offset(0, 5.0),
                blurRadius: 5.0,
              ),
            ]),
        child: avatar == null
            ? IconButton(
                onPressed: onAvatarClick,
                icon: Icon(
                  Icons.person,
                  color: Palette.ldaColor,
                ),
                iconSize: AVATAR_SIZE - 20,
              )
            : GestureDetector(
                onTap: onAvatarClick,
                child: CircleAvatar(
                  backgroundImage: FileImage(avatar),
                  radius: AVATAR_SIZE / 2,
                ),
              ),
      ),
      if (avatar == null)
        Positioned(
          right: 12,
          top: 12,
          child:
              FaIcon(FontAwesomeIcons.pen, size: 15, color: Palette.ldaColor),
        )
    ]);
  }

  Widget _getAvatarForLogin(File avatar) {
    return Container(
      width: AVATAR_SIZE,
      decoration: BoxDecoration(
          color: Palette.penelopeColor,
          shape: BoxShape.circle,
          border: Border.all(color: Palette.white, width: 3)),
      child: IconButton(
        icon: Icon(
          Icons.person,
          color: Palette.white,
        ),
        iconSize: AVATAR_SIZE - 20,
      ),
    );
  }
}
