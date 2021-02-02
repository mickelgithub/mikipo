import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/widget/avatar_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_form_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_header_widget.dart';
import 'package:mikipo/src/ui/login/widget/login_footer_widget.dart';
import 'package:mikipo/src/ui/login/widget/submit_button_widget.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

const double FORM_LOGIN_HEIGHT = 260.0;
const double FORM_LOGUP_HEIGHT = 330.0;
const double SUBMIT_BUTTON_SIZE = 60.0;
const double FORM_OFFSET_UP = 100.0;
const double FORM_TRANSLATION_Y = 130.0;
const int ANIM_DURATION = 200;
const double HEADER_HEIGHT_FACTOR = 0.4;
const double AVATAR_SIZE = 70;

class LoginScreen extends StatelessWidget {

  static final _logger= getLogger((LoginScreen).toString());

  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              LoginHeaderWidget(),
              LoginFooterWidget(),
              LoginFormWidget(),
              SubmitButtonWidget(),
              AvatarWidget(onAvatarClick: () {
                _onAvatarClick(context, viewModel);
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _onAvatarClick(BuildContext context, LoginViewModel viewModel) {
    _showModalSheetForManageAvatar(context, viewModel);
  }

  void _showModalSheetForManageAvatar(
      BuildContext context, LoginViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Palette.ldaColor,
                    ),
                    onPressed: () {
                      viewModel.pickAvatar(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.folder,
                      size: 40,
                      color: Palette.ldaColor,
                    ),
                    onPressed: () {
                      viewModel.pickAvatar(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                if (viewModel.avatarImage.value != null)
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                        color: Palette.ldaColor,
                      ),
                      onPressed: () {
                        viewModel.removeAvatar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
