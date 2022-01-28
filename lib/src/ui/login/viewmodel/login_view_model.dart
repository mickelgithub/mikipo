import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mikipo/src/domain/entity/auth/auth_failure.dart';
import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/domain/repository/avatar/avatar_repository.dart';
import 'package:mikipo/src/domain/usecase/auth/checkout_email_verification_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/login_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/register_user_usecase.dart';
import 'package:mikipo/src/domain/usecase/auth/update_user_profile_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/crop_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/delete_avatar_from_cach_usecase.dart';
import 'package:mikipo/src/domain/usecase/avatar/pick_image_usecase.dart';
import 'package:mikipo/src/domain/usecase/organization/get_organization_info_usecase.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_form_view_model.dart';
import 'package:mikipo/src/ui/login/viewmodel/state/registration_login_state.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:mikipo/src/util/validators/validators.dart';

enum RegistrationStep { start, moving, end }

enum LoginLogupOperation {
  login,
  logup,
  updateProfile
}

enum StepPage {
  loginLogup,
  inputProfile,
  validateMail,
  waitBossResponse
}

class LoginViewModel with ChangeNotifier {
  static final _logger = getLogger((LoginViewModel).toString());

  final PickImageUseCase _pickImageUsecase;
  final DeleteAvatarFromCacheUserCase _deleteAvatarFromCacheUserCase;
  final GetOrganizationInfoUseCase _getOrganizationInfoUseCase;
  final CropImageUseCase _cropImageUseCase;
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final CheckoutEmailVerificationUseCase _checkoutEmailVerificationUseCase;
  //final SendNewMemberNotificationUseCase _sendNewMemberNotificationUseCase;

  final PageController _loginLogupStepsPageViewController= PageController();
  PageController get loginLogupStepsPageViewController => _loginLogupStepsPageViewController;

  LoginFormViewModel _loginFormViewModel = LoginFormViewModel();
  LoginFormViewModel get loginFormViewModel => _loginFormViewModel;

  ValueNotifier<RegistrationLoginLogupState> _registrationState= ValueNotifier(null);
  RegistrationLoginLogupState get registrationState => _registrationState.value;
  ValueNotifier<RegistrationLoginLogupState> get registrationStateObservable => _registrationState;

  StepPage _stepPage= StepPage.loginLogup;
  StepPage get stepPage => _stepPage;

  LoginLogupOperation _operation;
  LoginLogupOperation get operation => _operation;
  bool _isOnlyLoginOperationAllowed= false;
  bool get isOnlyLoginOperationAllowed => _isOnlyLoginOperationAllowed;

  double _pageScroll;
  double get pageScroll => _pageScroll;

  User _user;
  User get user => _user;

  List<HeighProfile> heighProfiles;

  bool isJobProfileFormCompleted = false;

  File _avatar;
  File get avatar => _avatar;

  StreamSubscription<bool> _jobProfileCompletedSuscription;

  List<Section> sections;
  List<Area> areas;
  List<Department> departments;


  ///////////////////////////////////////

  bool get isUpdateProfile => this._operation== LoginLogupOperation.updateProfile;
  bool get isLogin => this._operation== LoginLogupOperation.login;

  void updatePage() {
    int pageIndex= _getPageIndex(_stepPage);
    if (pageIndex> 0) {
      /*_loginLogupStepsPageViewController.animateToPage(
          pageIndex, duration: Duration(milliseconds: 1000),
          curve: Curves.decelerate);*/
      _loginLogupStepsPageViewController.jumpToPage(pageIndex);
    }
  }

  int _getPageIndex(StepPage stepPage) {
    switch (stepPage) {
      case StepPage.loginLogup:
        return 0;
      case StepPage.inputProfile:
        return 1;
      case StepPage.validateMail:
        return 2;
      case StepPage.waitBossResponse:
        return 3;
    }
  }

  void _doLogin() async {

    _logger.d('do signin...');
    final result = await _loginUserUseCase(
        email: _loginFormViewModel.editEmailController.value.text,
        pass: _loginFormViewModel.editPassController.value.text);

    result.fold((l) {
      _registrationState.value = null;

      if (l is UserDisabled) {
        _registrationState.value = LoginUserDisabled();
      } else if (l is UserDischarged) {
        _registrationState.value = LoginUserDischarged();
      } else {
        _registrationState.value = RegistrationLoginLogupStateError(l);
      }
    }, (user) {
      _registrationState.value = null;
      _registrationState.value= RegistrationLoginLogupStateOk();
      Future.delayed(Duration(milliseconds: 1000), () {
        _registrationState.value = null;
       _registrationState.value= LoginStateOK(user);
      });
    });
  }

  Future<void> _getOrganizationInfo() async {
    if (sections == null) {
      _logger.d('vamos a obtener la info de la organizacion....');
      final result = await _getOrganizationInfoUseCase();
      result.fold((l) {
        _registrationState.value= RegistrationLoginLogupStateError(l);
      }, (r) {
        sections = r.sections;
        heighProfiles = r.heighProfiles;
        notifyListeners();
      });
    }
  }

  Future<void> _doRegistration() async {
    _registrationState.value= RegistrationLoginLogupStateLoading();
    _logger.d(
        'Todo listo para registrar esta info ${_loginFormViewModel.editEmailController.value.text}:${_loginFormViewModel.editPassController.value.text}:${_loginFormViewModel.editConfirmPassController.value.text}');
    final result = await _registerUserUseCase(
        email: _loginFormViewModel.editEmailController.value.text,
        pass: _loginFormViewModel.editPassController.value.text,
        avatar: avatar,
        heighProfile: _loginFormViewModel.getHeighProfileValue(),
        section: _loginFormViewModel.getSectionValue(),
        area: _loginFormViewModel.getAreaValue(),
        department: _loginFormViewModel.getDepartmentValue());
    result.fold((l) {
      _registrationState.value = null;
      _registrationState.value = RegistrationLoginLogupStateError(l);
    }, (r) {
      _user= r;
      _registrationState.value = null;
      _registrationState.value= RegistrationLoginLogupStateOk();
      Future.delayed(Duration(milliseconds: 1000), () {
        _registrationState.value = null;
        _loginLogupStepsPageViewController.animateToPage(
            2, duration: Duration(milliseconds: 1000),
            curve: Curves.decelerate);
      });
    });
  }

  void _doCheckoutMailVerification() async {
    final isEmailVerifiedResult= await _checkoutEmailVerificationUseCase(_user);
    isEmailVerifiedResult.fold((failure) {
      _registrationState.value= RegistrationLoginLogupStateError(InternetNotAvailable());
    }, (isEmailVerified) async {
      if (isEmailVerified) {
        _loginLogupStepsPageViewController.animateToPage(
            3, duration: Duration(milliseconds: 1000),
            curve: Curves.decelerate);
      } else {
        _registrationState.value= RegistrationLoginLogupStateError(UserEmailNotVerifiedYet());
      }
    });
  }

  void submitLoginLogupForm() {
    if (isLogin) {
      _doLogin();
    } else {
      //it's registration., so we go to next step, the job profile form
      if (_stepPage== StepPage.loginLogup) {
        if (!_loginFormViewModel.isEqualPassAndConfirmPass()) {
          _loginFormViewModel.showErrorInConfirmPass(Validators.PASS_NOT_MATCH);
        } else {
          _loginLogupStepsPageViewController.animateToPage(
              1, duration: Duration(milliseconds: 1000),
              curve: Curves.decelerate);
          _getOrganizationInfo();
        }
      } else if (_stepPage== StepPage.inputProfile) {
        _doRegistration();
      } else if (_stepPage== StepPage.validateMail) {
        _doCheckoutMailVerification();
      }
    }
    notifyListeners();
  }

  void changeHeighProfile(HeighProfile heighProfile) {
    if (_loginFormViewModel.isHeighProfileHasChanged(heighProfile)) {
      if (heighProfile.level == HeighProfile.DIRECTOR) {
        areas = [];
        departments = [];
        notifyListeners();
      } else if (heighProfile.level == HeighProfile.AREA_CHEF) {
        departments = [];
        notifyListeners();
      }
      _loginFormViewModel.changeHeighProfile(heighProfile);
      _loginFormViewModel.changeSection(null);
      _loginFormViewModel.changeArea(null);
      _loginFormViewModel.changeDepartment(null);
    }
  }

  void changeSection(Section section) {
    if (_loginFormViewModel.isSectionHasChanged(section)) {
      _loginFormViewModel.changeSection(section);
      if (!_loginFormViewModel.isDirector()) {
        areas = section.areas;
        departments = null;
        _loginFormViewModel.changeArea(null);
        _loginFormViewModel.changeDepartment(null);
        notifyListeners();
      }
    }
  }

  void changeArea(Area area) {
    if (_loginFormViewModel.isAreaHasChanged(area)) {
      _loginFormViewModel.changeArea(area);
      if (!_loginFormViewModel.isAreaChef()) {
        departments = area.departments;
        _loginFormViewModel.changeDepartment(null);
        notifyListeners();
      }
    }
  }

  void changeLoginLogupOperation(LoginLogupOperation loginLogupOperation) async {
    if (_operation== loginLogupOperation) return;
    _operation= loginLogupOperation;
    _loginFormViewModel.clearEmailField();
    _loginFormViewModel.clearPassField();
    _loginFormViewModel.clearConfirmPassField();
    if (_avatar!= null) {
      await _deleteAvatarFromCacheUserCase(_avatar);
      _avatar= null;
    }
    notifyListeners();
  }

  Future<void> pickAvatar(ImageSource imageSource) async {
    File newAvatarImageFile = await _pickImageUsecase(imageSource);
    if (newAvatarImageFile == null) return;
    //we cropp the image
    print('This is the path of the picked image ${newAvatarImageFile.path}');
    File avatarImageCropped = await _cropImageUseCase(newAvatarImageFile);
    if (avatarImageCropped == null) {
      await _deleteAvatarFromCacheUserCase(newAvatarImageFile);
      return;
    }
    File currentAvatarImage = _loginFormViewModel.getAvatarValue();
    if (currentAvatarImage != null) {
      await _deleteAvatarFromCacheUserCase(currentAvatarImage);
    }
    await _deleteAvatarFromCacheUserCase(newAvatarImageFile);
    print('This is the path of the cropped image ${avatarImageCropped.path}');
    _avatar= avatarImageCropped;
    notifyListeners();
  }

  Future<void> removeAvatar() async {
    _logger.d(
        '$hashCode................................${_loginFormViewModel.getAvatarValue()}');
    if (_loginFormViewModel.getAvatarValue() != null) {
      File avatar = _loginFormViewModel.getAvatarValue();
      _logger.d('$hashCode a borrar el avatar ${avatar.path}');
      await _deleteAvatarFromCacheUserCase(avatar);
      _logger.d('$hashCode Se habra borrado el avatar ${avatar.path}');
    }
    _avatar= null;
    notifyListeners();
  }

  void _listenToPageViewScroll() {
    _pageScroll= _loginLogupStepsPageViewController.page;
    if (_stepPage== StepPage.loginLogup && _pageScroll== 1.0) {
      _stepPage= StepPage.inputProfile;
    } else if (_stepPage== StepPage.inputProfile && _pageScroll== 2.0) {
      _stepPage= StepPage.validateMail;
    } else if (_stepPage== StepPage.validateMail && _pageScroll== 3.0) {
      _stepPage= StepPage.waitBossResponse;
    }
    print('${_stepPage.toString()} ------- $_pageScroll');
    notifyListeners();
  }

  void init(StepPage stepPage, User user, LoginLogupOperation operation) {
    _operation= operation;
    _stepPage= stepPage;
    if ((_operation == LoginLogupOperation.login ||
        _operation == LoginLogupOperation.logup) && stepPage== null) {
      _stepPage = StepPage.loginLogup;
    } else if (_operation == LoginLogupOperation.updateProfile) {
      _stepPage = StepPage.inputProfile;
    }
    if (_operation == LoginLogupOperation.login) {
      _isOnlyLoginOperationAllowed = true;
    }
    _user = user;
    _loginLogupStepsPageViewController.addListener(_listenToPageViewScroll);
    //notifyListeners();
  }

  @override
  void dispose() {
    print('view model disposed $hashCode');
    _jobProfileCompletedSuscription.cancel();
    _loginLogupStepsPageViewController.removeListener(_listenToPageViewScroll);
    _loginLogupStepsPageViewController.dispose();
    _loginFormViewModel.dispose();
    _registrationState.dispose();
    super.dispose();
  }

  /*void moveStepToEnd() {
    //registrationStep = RegistrationStep.end;
    //notifyListeners();
  }*/


  //*****************************************************************




  //User _boss;
  //GetUserStreamUseCase _getUserStreamUseCase;

  LoginViewModel(
      this._pickImageUsecase,
      this._deleteAvatarFromCacheUserCase,
      this._getOrganizationInfoUseCase,
      this._cropImageUseCase,
      this._registerUserUseCase,
      this._loginUserUseCase,
      this._updateUserProfileUseCase,
      this._checkoutEmailVerificationUseCase) {

    _jobProfileCompletedSuscription = _loginFormViewModel.isJobProfileFormCompleted
        .listen((completed) {
      isJobProfileFormCompleted = completed;
      notifyListeners();
    });
    _logger.d('$hashCode');
  }

  /*void init(LoginLogupAction action, User user,
      GetUserStreamUseCase getUserStreamUseCase) {
    this.loginLogupAction = action ?? LoginLogupAction.logup;
    if (action != null) {
      _user = user;
      _getUserStreamUseCase = getUserStreamUseCase;
      _loginFormViewModel.changeEmail(user.email);
      _loginFormViewModel.changePass(user.pass);
      _loginFormViewModel.changeConfirmPass(user.pass);
      this.registrationStep = RegistrationStep.end;
      _getOrganizationInfo();
    }
  }*/





























    /*void onChangeOperation(LoginLogupOperation operation) async {
      if (_operation == operation) return;
      _operation = operation;
      _loginFormViewModel.clearPassField();
      _loginFormViewModel.clearConfirmPassField();
      _loginFormViewModel.clearEmailField();
      if (operation == LoginLogupOperation.login) {
        _logger.d('$hashCode borramos avatar en caso de existir');
        await removeAvatar();
        _logger.d('$hashCode deberia de estar borrado en caso de existir');
      }

      notifyListeners();
    }*/

    void onSubmitForm() async {
      /*_logger.d('.............................');
    if (operation == LoginLogupOperation.login) {
      _logger.d('do signin...');
      final result = await _loginUserUseCase(
          email: _loginFormViewModel.editEmailController.value.text,
          pass: _loginFormViewModel.editPassController.value.text);
      if (result != null) {
        registrationState = RegistrationLoginStateError(result);
        notifyListeners();
      }
    } else if (operation == LoginLogupOperation.logup) {
      if (!_loginFormViewModel.isEqualPassAndConfirmPass()) {
        _loginFormViewModel.showErrorInConfirmPass(Validators.PASS_NOT_MATCH);
      } else {
        if (registrationStep == RegistrationStep.start) {
          registrationStep = RegistrationStep.moving;
          _logger.d('go to next step for registration....');
          //Here we have to pull out the orfanizacion info
          _getOrganizationInfo();
          notifyListeners();
        } else if (registrationStep == RegistrationStep.end) {
          //do registration
          if (isJobProfileFormCompleted) {
            _logger.d(
                'Todo listo para registrar esta info ${_loginFormViewModel.editEmailController.value.text}:${_loginFormViewModel.editPassController.value.text}:${_loginFormViewModel.editConfirmPassController.value.text}');
            final result = await _registerUserUseCase(
                email: _loginFormViewModel.editEmailController.value.text,
                pass: _loginFormViewModel.editPassController.value.text,
                avatar: _loginFormViewModel.getAvatarValue(),
                heighProfile: _loginFormViewModel.getHeighProfileValue(),
                section: _loginFormViewModel.getSectionValue(),
                area: _loginFormViewModel.getAreaValue(),
                department: _loginFormViewModel.getDepartmentValue());
            if (result != null) {
              registrationState = RegistrationLoginStateError(result);
              notifyListeners();
            }
          } else {
            _logger.d('Hay que introducir mas datos...................');
          }
        }
      }
    } else {
      //update profile
      _logger.d('do update profile');
      await _updateUserProfileUseCase(
          user: _user,
          heighProfile: _loginFormViewModel.getHeighProfileValue(),
          section: _loginFormViewModel.getSectionValue(),
          area: _loginFormViewModel.getAreaValue(),
          department: _loginFormViewModel.getDepartmentValue());

      final updatedUser = _user.copyWith(isAcceptedByChef: '');
      _getUserStreamUseCase.updateUser(updatedUser);
    }*/
    }

}
