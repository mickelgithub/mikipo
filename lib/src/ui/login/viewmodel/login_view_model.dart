import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/domain/usecase/auth/login_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/register_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/crop_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/delete_avatar_from_cach_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/pick_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/organization/get_organization_info_usecase.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_form_view_model.dart';
import 'package:mikipo/src/ui/login/viewmodel/state/registration_login_state.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/validators/validators.dart';
import 'package:mikipo/src/util/extensions/file_extensions.dart';

enum LoginLogupAction { login, logup }
enum KeyBoardState {closed, opened}
enum RegistrationStep {start, moving, end}

class LoginViewModel {

  static final _logger= getLogger((LoginViewModel).toString());

  LoginFormViewModel _loginFormViewModel= LoginFormViewModel();
  LoginFormViewModel get loginFormViewModel => _loginFormViewModel;

  final PickImageUseCase _pickImageUsecase;
  final DeleteAvatarFromCacheUserCase _deleteAvatarFromCacheUserCase;
  final GetOrganizationInfoUseCase _getOrganizationInfoUseCase;
  final CropImageUseCase _cropImageUseCase;
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;

  LoginViewModel(this._pickImageUsecase, this._deleteAvatarFromCacheUserCase,
      this._getOrganizationInfoUseCase, this._cropImageUseCase,
      this._registerUserUseCase, this._loginUserUseCase) {
    isKeyBoardVisible.map((isVisible) => isVisible ? KeyBoardState.opened : KeyBoardState.closed).listen((state) {
      keyBoardState.value= state;
    });
    loginFormViewModel.registrationReady.listen((event) {
      registrationReady.value= event;
    });
  }

  Stream<bool> isKeyBoardVisible= KeyboardVisibilityController().onChange;

  ValueNotifier<LoginLogupAction> loginLogupAction= ValueNotifier(LoginLogupAction.logup);
  ValueNotifier<KeyBoardState> keyBoardState= ValueNotifier(KeyBoardState.closed);
  ValueNotifier<File> avatarImage= ValueNotifier(null);
  ValueNotifier<RegistrationStep> registrationStep= ValueNotifier(RegistrationStep.start);
  ValueNotifier<List<Section>> sections= ValueNotifier(null);
  ValueNotifier<List<HeighProfile>> heighProfiles= ValueNotifier(null);
  ValueNotifier<List<Area>> areas= ValueNotifier(null);
  ValueNotifier<List<Department>> departments= ValueNotifier(null);
  ValueNotifier<bool> registrationReady= ValueNotifier(false);
  ValueNotifier<RegistrationLoginState> registrationState= ValueNotifier(null);

  void changeHeighProfile(HeighProfile heighProfile) {
    if (loginFormViewModel.isHeighProfileHasChanged(heighProfile)) {
      if (heighProfile.level== HeighProfile.DIRECTOR) {
        areas.value= [];
        departments.value= [];
      } else if (heighProfile.level== HeighProfile.AREA_CHEF) {
        departments.value= [];
      }
      loginFormViewModel.changeHeighProfile(heighProfile);
      loginFormViewModel.changeSection(null);
      loginFormViewModel.changeArea(null);
      loginFormViewModel.changeDepartment(null);
    }
  }

  void changeSection(Section section) {
    if (loginFormViewModel.isSectionHasChanged(section)) {
      loginFormViewModel.changeSection(section);
      if (!loginFormViewModel.isDirector()) {
        areas.value= section.areas;
        departments.value= null;
        loginFormViewModel.changeArea(null);
        loginFormViewModel.changeDepartment(null);
      }
    }
  }

  void changeArea(Area area) {
    if (loginFormViewModel.isAreaHasChanged(area)) {
      loginFormViewModel.changeArea(area);
      if (!loginFormViewModel.isAreaChef()) {
        departments.value= area.departments;
        loginFormViewModel.changeDepartment(null);
      }
    }
  }

  void onChangeAction(LoginLogupAction action) {
    if (loginLogupAction.value== action) return;
    loginLogupAction.value= action;
    _loginFormViewModel.clearPassField();
    _loginFormViewModel.clearConfirmPassField();
    _loginFormViewModel.clearEmailField();
  }

  void onSubmitForm() async {
    _logger.d('.............................');
    if (loginLogupAction.value== LoginLogupAction.login) {
      //do signin
      _logger.d('do signin...');
      final result= await _loginUserUseCase(email: loginFormViewModel.editEmailController.value.text,
          pass: loginFormViewModel.editPassController.value.text);
      if (result!= null) {
        registrationState.value= RegistrationLoginStateError(result);
      }
    } else {
      if (!_loginFormViewModel.isEqualPassAndConfirmPass()) {
        _loginFormViewModel.showErrorInConfirmPass(Validators.PASS_NOT_MATCH);
      } else {
        if (registrationStep.value== RegistrationStep.start) {
          registrationStep.value= RegistrationStep.moving;
          _logger.d('go to next step for registration....');
          //Here we have to pull out the orfanizacion info
          getOrganizationInfo();
        } else if (registrationStep.value== RegistrationStep.end) {
          //do registration
          if (registrationReady.value) {
            _logger.d('Todo listo para registrar esta info ${loginFormViewModel.editEmailController.value.text}:${loginFormViewModel.editPassController.value.text}:${loginFormViewModel.editConfirmPassController.value.text}');
            final result= await _registerUserUseCase(email: loginFormViewModel.editEmailController.value.text,
            pass: loginFormViewModel.editPassController.value.text,
            avatar: avatarImage.value, heighProfile: _loginFormViewModel.getHeighProfile(),
            section: _loginFormViewModel.getSection(), area: _loginFormViewModel.getArea(),
            department: _loginFormViewModel.getDepartment());
            if (result!= null) {
              registrationState.value= RegistrationLoginStateError(result);
            }
          } else {
            _logger.d('Hay que introducir mas datos...................');
          }
        }

      }
    }
  }

  void moveStepToEnd() {
    registrationStep.value= RegistrationStep.end;
  }

  Future<void> getOrganizationInfo() async {
    if (sections.value== null) {
      _logger.d('vamos a obtener la info de la organizacion....');
      final organization= await _getOrganizationInfoUseCase();
      sections.value= organization.sections;
      heighProfiles.value= organization.heighProfiles;
    }

  }

  Future<void> pickAvatar(ImageSource imageSource) async {
    File newAvatarImageFile= await _pickImageUsecase(imageSource);
    if (newAvatarImageFile== null) return;
    if (avatarImage.value!= null) {
        bool areIgual= await avatarImage.value.byteCompare(newAvatarImageFile);
        if (areIgual) {
          await _deleteAvatarFromCacheUserCase(newAvatarImageFile);
          print('The picked image is equal to the one prevously picked, no further action');
          return;
        }
        await _deleteAvatarFromCacheUserCase(avatarImage.value);
    }
    //we cropp the image
    print('This is the path of the picked image ${newAvatarImageFile.path}');
    File avatarImageCropped= await _cropImageUseCase(newAvatarImageFile);
    await _deleteAvatarFromCacheUserCase(newAvatarImageFile);
    if (avatarImageCropped== null) {
      avatarImage.value= null;
      return;
    }
    print('This is the path of the cropped image ${avatarImageCropped.path}');
    avatarImage.value= avatarImageCropped;
  }

  Future<void> removeAvatar() async {
    await _deleteAvatarFromCacheUserCase(avatarImage.value);
    avatarImage.value= null;
  }

  void dispose() {
    print('view model disposed ${hashCode}');
    _loginFormViewModel.dispose();
  }
}