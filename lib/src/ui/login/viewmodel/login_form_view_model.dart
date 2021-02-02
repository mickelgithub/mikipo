import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';

class LoginFormViewModel with Validators {

  TextEditingController editEmailController= TextEditingController();
  TextEditingController editPassController= TextEditingController();
  TextEditingController editConfirmPassController= TextEditingController();

  final BehaviorSubject<String> _emailController= BehaviorSubject<String>();
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final BehaviorSubject<String> _passController= BehaviorSubject<String>();
  Stream<String> get pass => _passController.stream.transform(validatePass);

  final BehaviorSubject<Section> _sectionController= BehaviorSubject<Section>();
  Stream<Section> get section => _sectionController.stream;

  Section getSection() => _sectionController.value;

  final BehaviorSubject<HeighProfile> _heighProfileController= BehaviorSubject<HeighProfile>();
  Stream<HeighProfile> get heighProfiles => _heighProfileController.stream;

  HeighProfile getHeighProfile() => _heighProfileController.value;

  final BehaviorSubject<Area> _areaController= BehaviorSubject<Area>();
  Stream<Area> get area => _areaController.stream;

  Area getArea() => _areaController.value;

  final BehaviorSubject<Department> _departmentController= BehaviorSubject<Department>();
  Stream<Department> get department => _departmentController.stream;

  Department getDepartment() => _departmentController.value;

  final BehaviorSubject<String> _confirmPassController= BehaviorSubject<String>();
  Stream<String> get confirmPass => _confirmPassController.stream.transform(validatePass);

  Stream<bool> get submitLogin => Rx.combineLatest2<String,String, bool>(email, pass, (_,__) => true);
  Stream<bool> get submitLogup => Rx.combineLatest3<String,String,String, bool>(email, pass, confirmPass, (_,__, ___) => true);

  Stream<bool> get registrationReady => Rx.combineLatest4<HeighProfile,Section,Area,Department, bool>(heighProfiles, section, area, department, (h, s,a,d) {
    if (h.level== HeighProfile.DIRECTOR) {
      return s!= null;
    } else if (h.level== HeighProfile.AREA_CHEF) {
      return s!= null && a!= null;
    } else {
      return s != null && a != null && d != null;
    }
  });

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;
  Function(String) get changeConfirmPass => _confirmPassController.sink.add;
  Function(HeighProfile) get changeHeighProfile => _heighProfileController.sink.add;
  Function(Section) get changeSection => _sectionController.sink.add;
  Function(Area) get changeArea => _areaController.sink.add;
  Function(Department) get changeDepartment => _departmentController.sink.add;


  void clearEmailField() {
    if (editEmailController.value.text.length> 0) {
      editEmailController.clear();
      _emailController.sink.addError('');
    }
  }

  void clearPassField() {
    if (editPassController.value.text.length> 0) {
      editPassController.clear();
      _passController.sink.addError('');
    }
  }

  void clearConfirmPassField() {
    if (editConfirmPassController.value.text.length> 0) {
      editConfirmPassController.clear();
      _confirmPassController.sink.addError('');
    }
  }

  bool isEqualPassAndConfirmPass() {
    print('${_passController.value}:${_confirmPassController.value}');
    return _passController.value== _confirmPassController.value;
  }

  void showErrorInConfirmPass(String error) {
    editConfirmPassController.clear();
    _confirmPassController.sink.addError(error);
  }

  void dispose() {
    _emailController.close();
    _passController.close();
    _confirmPassController.close();
    editPassController.dispose();
    editConfirmPassController.dispose();
  }

  bool isDirector() {
    return _heighProfileController.value.level== HeighProfile.DIRECTOR;
  }

  bool isAreaChef() {
    return _heighProfileController.value.level== HeighProfile.AREA_CHEF;
  }

  bool isHeighProfileHasChanged(HeighProfile heighProfile) {
    return _heighProfileController.value!= heighProfile;
  }

  bool isSectionHasChanged(Section section) {
    return _sectionController.value!= section;
  }

  bool isAreaHasChanged(Area area) {
    return _areaController.value!= area;
  }

}