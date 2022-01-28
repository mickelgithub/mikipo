import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';

enum BottonSheetFeedback {
  loading, success
}

class BottomSheetWidget {


  static void showMessageBottomSheetWidget({@required BuildContext context, @required String message, bool isModal= false}) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: !isModal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                        color: Palette.ldaColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showModalSheetToManageAvatar(
  {@required BuildContext context, @required LoginViewModel viewModel}) {
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
          return Container(
            height: 80,
            child: Padding(
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
                  if (viewModel.avatar != null)
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
            ),
          );
        });
  }

  static void showModalSheetForLoadingSuccess({
      @required BuildContext context, BottonSheetFeedback feedback= BottonSheetFeedback.loading}) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: feedback!= BottonSheetFeedback.loading,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => feedback== BottonSheetFeedback.loading ? false : true,
            child: Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (feedback== BottonSheetFeedback.loading)
                    SpinKitCircle(
                      size: 50.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    if (feedback== BottonSheetFeedback.success)
                      SpinKitPumpingHeart(
                        size: 50.0,
                        color: Theme.of(context).primaryColor,
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void hideBottomSheet(BuildContext context) {
    print('lets hide....');
    Navigator.of(context).pop();
  }

}

