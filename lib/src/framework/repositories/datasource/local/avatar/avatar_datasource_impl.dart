import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mikipo/src/framework/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/ui/common/colors.dart';

class AvatarLocalDatasourceImpl extends IAvatarLocalDatasource {

  final ImagePicker imagePicker;

  AvatarLocalDatasourceImpl(this.imagePicker);

  @override
  Future<File> pickImageFromCamera() async {
    final pickedImageFile =  await _pickImage(ImageSource.camera);
    if (pickedImageFile != null) {
      print('picked image from camera and the path is ${pickedImageFile.path}');
    }
    return pickedImageFile;
  }

  @override
  Future<File> pickImageFromGallery() async {
    final pickedImageFile =  await _pickImage(ImageSource.gallery);
    return pickedImageFile;
  }
  
  Future<File> _pickImage(ImageSource imageSource) async {
    final pickedImage =  await imagePicker.getImage(source: imageSource);
    if (pickedImage != null) {
      File avatarImage = File(pickedImage.path);
      return avatarImage;
    }
    return null;
  }

  @override
  Future<File> cropImage(File image) {
    return ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
      ],
      androidUiSettings: _androidUiSettings(),
    );
  }

  AndroidUiSettings _androidUiSettings() => AndroidUiSettings(
    hideBottomControls: false,
    initAspectRatio: CropAspectRatioPreset.original,
    toolbarTitle: 'Editar imagen',
    toolbarColor: Palette.ldaColor,
    toolbarWidgetColor: Palette.white,
    lockAspectRatio: false,
  );

}