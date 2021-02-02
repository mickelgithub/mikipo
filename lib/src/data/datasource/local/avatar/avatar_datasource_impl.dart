import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mikipo/src/data/datasource/local/avatar/avatar_datasource.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mikipo/src/util/extensions/string_extensions.dart';

class AvatarLocalDatasourceImpl extends IAvatarLocalDatasource {

  static const String _AVATAR_NAME= 'avatar';
  static const String _AVATAR_DIRECTORY= 'avatar';
  static const String _CROPPER_TITLE= 'Editar imagen';

  static final _logger= getLogger((AvatarLocalDatasourceImpl).toString());

  final ImagePicker imagePicker;

  AvatarLocalDatasourceImpl(this.imagePicker);

  @override
  Future<File> pickImageFromCamera() async {
    final pickedImageFile =  await _pickImage(ImageSource.camera);
    if (pickedImageFile != null) {
      _logger.d('picked image from camera and the path is ${pickedImageFile.path}');
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
    toolbarTitle: _CROPPER_TITLE,
    toolbarColor: Palette.ldaColor,
    toolbarWidgetColor: Palette.white,
    lockAspectRatio: false,
  );

  @override
  Future<File> saveImage(File image) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final imageName= '${_AVATAR_NAME}${image.path.extension}';
    Directory avatarDirectory= Directory('${appDocPath}/${_AVATAR_DIRECTORY}/');
    final bool avatarDirectoryExist= await avatarDirectory.exists();
    if (!avatarDirectoryExist) {
      _logger.d('${avatarDirectory.path} do not exist');
      await avatarDirectory.create();
    } else {
      _logger.d('${avatarDirectory.path} already existe');
    }
    File fileResult= await image.copy('${appDocPath}/${_AVATAR_DIRECTORY}/${imageName}');
    _logger.d('Ya hemos copiado el avatar ${image.path} a local ${fileResult.path}');
    return fileResult;
  }

  @override
  Future<void> removeImage(File image) async {
    await image.delete();
    _logger.d('Se ha borrado correctamente el fichero ${image.path}');
  }

  @override
  Future<File> getFileForAvatar(String extension) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final imageName= '${_AVATAR_NAME}${extension}';
    Directory avatarDirectory= Directory('${appDocPath}/${_AVATAR_DIRECTORY}/');
    final bool avatarDirectoryExist= await avatarDirectory.exists();
    if (!avatarDirectoryExist) {
      _logger.d('${avatarDirectory.path} no existe!!!!!!!!!!!!!!');
      await avatarDirectory.create();
    } else {
      _logger.d('${avatarDirectory.path} YAAAAAA existe!!!!!!!!!!!!!!');
    }
    return File('${appDocPath}/${_AVATAR_DIRECTORY}/${imageName}');
  }

  @override
  Future<void> removeAvatar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Directory avatarDirectory= Directory('${appDocPath}/${_AVATAR_DIRECTORY}/');
    final bool avatarDirectoryExist= await avatarDirectory.exists();
    if (avatarDirectoryExist) {
      avatarDirectory.list(recursive: false).listen((entity) {
        entity.delete();
        _logger.d('${entity.path} is deleted...');
      });
    }
  }

}