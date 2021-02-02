import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/common/component/input_text_widget.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/util/icon/icons_map.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatelessWidget {

  static const String _LOADING= 'Cargando...';
  static const String _PASS_HINT= 'Contraseña';
  static const String _CONFIRM_PASS_HINT= 'Confirmar contraseña';
  static const String _PICK_SECTION= 'Elige tu seccion';
  static const String _PICK_PROFILE= 'Elige tu perfil';
  static const String _PICK_AREA= 'Elige tu area';
  static const String _PICK_DEPARTMENT= 'Elige tu departamente';
  static const String _NOT_AVAILABLE= 'No disponible';
  static const String _LOGIN= 'ACCEDER';
  static const String _LOGUP= 'REGISTRARSE';


  static final _logger= getLogger((LoginFormWidget).toString());

  const LoginFormWidget();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    final size = MediaQuery.of(context).size;
    double topBackHeight = size.height * HEADER_HEIGHT_FACTOR;
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return Consumer6<
            ValueNotifier<LoginLogupAction>,
            ValueNotifier<KeyBoardState>,
            ValueNotifier<RegistrationStep>,
            ValueNotifier<List<Section>>,
            ValueNotifier<List<Area>>,
            ValueNotifier<List<Department>>>(
        builder: (context, action, keyBoardState, registrationStep,
            sections, areas, departments, _) {

          return Consumer<ValueNotifier<List<HeighProfile>>>(
            builder: (context2, heighProfiles, __) {
              final FocusScopeNode node = FocusScopeNode();
              if (keyBoardState.value == KeyBoardState.closed) {
                SystemChrome.setEnabledSystemUIOverlays([]);
              }
              return AnimatedPositioned(
                duration: Duration(milliseconds: ANIM_DURATION),
                top: topBackHeight -
                    FORM_OFFSET_UP -
                    (keyBoardState.value == KeyBoardState.opened
                        ? FORM_TRANSLATION_Y
                        : 0),
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: ANIM_DURATION),
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  padding: EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    color: Palette.ldaColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.black.withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  height: action.value == LoginLogupAction.logup
                      ? FORM_LOGUP_HEIGHT
                      : FORM_LOGIN_HEIGHT,
                  child: _getForm(
                      size,
                      viewModel,
                      node,
                      action.value,
                      registrationStep.value,
                      sections.value,
                      heighProfiles.value,
                      areas.value,
                      departments.value),
                ),
              );
            }
          );
    });
  }

  Widget _getForm(
      Size size,
      LoginViewModel viewModel,
      FocusScopeNode node,
      LoginLogupAction action,
      RegistrationStep registrationStep,
      List<Section> sections,
      List<HeighProfile> heighProfiles,
      List<Area> areas,
      List<Department> departments) {
    return Form(
      child: FocusScope(
        node: node,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _getFormActions(viewModel, action, registrationStep),
                SizedBox(
                  height: 30,
                ),
                //the first page
                if (registrationStep == RegistrationStep.start ||
                    registrationStep == RegistrationStep.moving) ...[
                  _getEmailInput(registrationStep, size, viewModel, node),
                  SizedBox(
                    height: 5,
                  ),
                    _getPassInput(
                        registrationStep, size, viewModel, action, node),
                  if (action == LoginLogupAction.logup) ...[
                    SizedBox(
                      height: 5,
                    ),
                    if (registrationStep == RegistrationStep.start ||
                        registrationStep == RegistrationStep.moving)
                      _getConfirmPassInput(
                          viewModel, registrationStep, size, node),
                  ],
                ],
                //the second page
                if (registrationStep == RegistrationStep.end) ...[
                  _getHeighProfileInput(registrationStep, size,
                      viewModel, heighProfiles),
                  SizedBox(
                    height: 10,
                  ),
                  _getSectionInput(
                      registrationStep, size, viewModel, sections),
                  SizedBox(
                    height: 10,
                  ),
                  _getAreaInput(registrationStep, size, viewModel, areas),
                  SizedBox(
                    height: 10,
                  ),
                  _getDepartmentInput(
                      registrationStep, size, viewModel, areas, departments),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getConfirmPassInput(LoginViewModel viewModel,
      RegistrationStep registrationStep, Size size, FocusScopeNode node) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1600),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 0.0,
          end: registrationStep == RegistrationStep.moving ? -1.0 : 0.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder<Object>(
          stream: viewModel.loginFormViewModel.confirmPass,
          builder: (_, snapshot) {
            return InputTextWidget(
              hintText: _CONFIRM_PASS_HINT,
              textInputType: TextInputType.text,
              iconData: Icons.lock,
              onChanged: viewModel.loginFormViewModel.changeConfirmPass,
              value: '',
              error: snapshot.error,
              isDone: true,
              node: node,
              isPass: true,
              controller:
                  viewModel.loginFormViewModel.editConfirmPassController,
            );
          }),
    );
  }

  TweenAnimationBuilder<double> _getPassInput(
      RegistrationStep registrationStep,
      Size size,
      LoginViewModel viewModel,
      LoginLogupAction action,
      FocusScopeNode node) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1200),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 0.0,
          end: registrationStep == RegistrationStep.moving ? -1.0 : 0.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.pass,
        builder: (_, snapshot) => InputTextWidget(
          hintText: _PASS_HINT,
          textInputType: TextInputType.text,
          iconData: Icons.lock,
          onChanged: viewModel.loginFormViewModel.changePass,
          error: snapshot.error,
          isDone: action == LoginLogupAction.login,
          moveFocusTwice: action == LoginLogupAction.logup,
          node: node,
          isPass: true,
          controller: viewModel.loginFormViewModel.editPassController,
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getSectionInput(
      RegistrationStep registrationStep,
      Size size,
      LoginViewModel viewModel,
      List<Section> sections) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 1.0,
          end: registrationStep == RegistrationStep.end ? 0.0 : 1.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
          Matrix4.translationValues(-animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.section,
        initialData: null,
        builder: (_context, snapshot) => SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 4.0,
            color: Palette.ldaColor,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Section>(
                    dropdownColor: Palette.ldaColor,
                    icon: Icon(
                      // Add this
                      Icons.arrow_drop_down, // Add this
                      color: Palette.white, // Add this
                    ),
                    disabledHint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _LOADING,
                        style: TextStyle(color: Palette.white),
                      )
                    ]),
                    hint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _PICK_SECTION,
                        style: TextStyle(color: Palette.white),
                      ),
                    ]),
                    value: snapshot.data,
                    items: sections == null
                        ? null
                        : sections
                        .map(
                          (section) => DropdownMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              IconsMap.icons[section.icon],
                              color: Palette.white,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              section.name,
                              style: TextStyle(color: Palette.white),
                            ),
                          ],
                        ),
                        value: section,
                      ),
                    )
                        .toList(),
                    onChanged: viewModel.changeSection),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getHeighProfileInput(
      RegistrationStep registrationStep,
      Size size,
      LoginViewModel viewModel,
      List<HeighProfile> heighProfiles) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 1.0,
          end: registrationStep == RegistrationStep.end ? 0.0 : 1.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(-animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.heighProfiles,
        initialData: null,
        builder: (_context, snapshot) => SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 4.0,
            color: Palette.ldaColor,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<HeighProfile>(
                    dropdownColor: Palette.ldaColor,
                    icon: Icon(
                      // Add this
                      Icons.arrow_drop_down, // Add this
                      color: Palette.white, // Add this
                    ),
                    disabledHint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _LOADING,
                        style: TextStyle(color: Palette.white),
                      )
                    ]),
                    hint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _PICK_PROFILE,
                        style: TextStyle(color: Palette.white),
                      ),
                    ]),
                    value: snapshot.data,
                    items: heighProfiles == null
                        ? null
                        : heighProfiles
                            .map(
                              (heighProfile) => DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Palette.white,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      heighProfile.name,
                                      style: TextStyle(color: Palette.white),
                                    ),
                                  ],
                                ),
                                value: heighProfile,
                              ),
                            )
                            .toList(),
                    onChanged: viewModel.changeHeighProfile),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getAreaInput(RegistrationStep registrationStep,
      Size size, LoginViewModel viewModel, List<Area> areas) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 1.0,
          end: registrationStep == RegistrationStep.end ? 0.0 : 1.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(-animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.area,
        initialData: null,
        builder: (_context, snapshot) => SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 4.0,
            color: Palette.ldaColor,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Area>(
                    dropdownColor: Palette.ldaColor,
                    icon: Icon(
                      // Add this
                      Icons.arrow_drop_down, // Add this
                      color: Palette.white, // Add this
                    ),
                    disabledHint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        areas == null ? _LOADING : _NOT_AVAILABLE,
                        style: TextStyle(color: Palette.white),
                      )
                    ]),
                    hint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _PICK_AREA,
                        style: TextStyle(color: Palette.white),
                      ),
                    ]),
                    value: snapshot.data,
                    items: areas == null
                        ? null
                        : areas
                            .map(
                              (area) => DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      IconsMap.icons[area.icon],
                                      color: Palette.white,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      area.name,
                                      style: TextStyle(color: Palette.white),
                                    ),
                                  ],
                                ),
                                value: area,
                              ),
                            )
                            .toList(),
                    onChanged: viewModel.changeArea),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getDepartmentInput(
      RegistrationStep registrationStep,
      Size size,
      LoginViewModel viewModel,
      List<Area> areas,
      List<Department> departments) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1000),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 1.0,
          end: registrationStep == RegistrationStep.end ? 0.0 : 1.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(-animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.department,
        initialData: null,
        builder: (_context, snapshot) => SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 4.0,
            color: Palette.ldaColor,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Department>(
                    dropdownColor: Palette.ldaColor,
                    icon: Icon(
                      // Add this
                      Icons.arrow_drop_down, // Add this
                      color: Palette.white, // Add this
                    ),
                    disabledHint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        areas == null ? _LOADING : _NOT_AVAILABLE,
                        style: TextStyle(color: Palette.white),
                      )
                    ]),
                    hint: Row(children: [
                      Icon(Icons.height, color: Palette.ldaColor),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _PICK_DEPARTMENT,
                        style: TextStyle(color: Palette.white),
                      ),
                    ]),
                    value: snapshot.data,
                    items: departments == null
                        ? null
                        : departments
                            .map(
                              (department) => DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      IconsMap.icons[IconsMap.IT_SECTION_ICON],
                                      color: Palette.ldaColor,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      department.name,
                                      style: TextStyle(color: Palette.white),
                                    ),
                                  ],
                                ),
                                value: department,
                              ),
                            )
                            .toList(),
                    onChanged: viewModel.loginFormViewModel.changeDepartment),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _getEmailInput(
      RegistrationStep registrationStep,
      Size size,
      LoginViewModel viewModel,
      FocusScopeNode node) {
    return TweenAnimationBuilder(
      onEnd: viewModel.moveStepToEnd,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: 0.0,
          end: registrationStep == RegistrationStep.moving ? -1.0 : 0.0),
      builder: (_, animation, child) {
        return Transform(
          child: child,
          transform:
              Matrix4.translationValues(animation * size.width, 0.0, 0.0),
        );
      },
      child: StreamBuilder(
        stream: viewModel.loginFormViewModel.email,
        builder: (_context, snapshot) => InputTextWidget(
          hintText: 'Email',
          textInputType: TextInputType.emailAddress,
          iconData: Icons.email,
          onChanged: viewModel.loginFormViewModel.changeEmail,
          error: snapshot.error,
          node: node,
          controller: viewModel.loginFormViewModel.editEmailController,
        ),
      ),
    );
  }

  Widget _getFormActions(LoginViewModel viewModel, LoginLogupAction action,
      RegistrationStep registrationStep) {
    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 1000),
            curve: Curves.ease,
            tween: Tween<double>(
              begin: 1.0,
              end: registrationStep == RegistrationStep.end ? 0.0 : 1.0),
            builder: (_, animation, child) {
              return Opacity(
                child: child,
                opacity: animation);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.onChangeAction(LoginLogupAction.login);
                  },
                  child: Text(
                    _LOGIN,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: action == LoginLogupAction.login
                            ? Palette.white
                            : Colors.grey[400]),
                  ),
                ),
                if (action == LoginLogupAction.login) ...[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 60,
                    height: 2,
                    color: Palette.white,
                  ),
                ]
              ],
            ),
          ),
        ),
        Expanded(
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 1600),
            curve: Curves.bounceOut,
            tween: Tween<double>(
                begin: 0.0,
                end: registrationStep == RegistrationStep.end ? 1.0 : 0.0),
            builder: (_, animation, child) {
              return Transform(
                child: child,
                transform:
                Matrix4.translationValues(animation * -80, animation * 10, 0.0),
              );
            },
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.onChangeAction(LoginLogupAction.logup);
                  },
                  child: Text(
                    _LOGUP,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: action == LoginLogupAction.logup
                            ? Palette.white
                            : Colors.grey[400]),
                  ),
                ),
                if (action == LoginLogupAction.logup) ...[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 60,
                    height: 2,
                    color: Palette.white,
                  ),
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}
