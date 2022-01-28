import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/component/bottom_sheet_widget.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class ProfileAvatarWidget extends StatelessWidget {

  static const double AVATAR_SIZE = 70;

  @override
  Widget build(BuildContext context) {

    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return viewModel.isLogin ? _getAvatarForLogin() : _getAvatarForLogup(context, viewModel);
  }

  Widget _getAvatarForLogup(BuildContext context, LoginViewModel viewModel) {
    return Stack(children: [
      Container(
        width: AVATAR_SIZE,
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            shape: BoxShape.circle,
            border: viewModel.avatar == null
                ? Border.all(color: Palette.ldaColor, width: 3)
                : Border.all(width: 3, color: Palette.white),
            boxShadow: [
              BoxShadow(
                color: Palette.black.withOpacity(0.5),
                offset: Offset(0.0, 5.0),
                blurRadius: 5.0,
              ),
            ]),
        child: viewModel.avatar == null
            ? IconButton(
          onPressed: () {
            _onAvatarClick(context, viewModel);
          },
          icon: Icon(
            Icons.person,
            color: Palette.ldaColor,
          ),
          iconSize: AVATAR_SIZE - 20,
        )
            : GestureDetector(
          onTap: () {
            _onAvatarClick(context, viewModel);
          },
          child: CircleAvatar(
            backgroundImage: FileImage(viewModel.avatar),
            radius: AVATAR_SIZE / 2,
          ),
        ),
      ),
      if (viewModel.avatar == null)
        Positioned(
          right: 12,
          top: 12,
          child:
          FaIcon(FontAwesomeIcons.pen, size: 15, color: Palette.ldaColor),
        )
    ]);
  }

  Widget _getAvatarForLogin() {
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
        onPressed: null,
      ),
    );
  }

  void _onAvatarClick(BuildContext context, LoginViewModel viewModel) {
    BottomSheetWidget.showModalSheetToManageAvatar(context: context, viewModel: viewModel);
  }



}
