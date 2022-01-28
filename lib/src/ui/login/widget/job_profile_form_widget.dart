import 'package:flutter/material.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/ui/login/viewmodel/login_view_model.dart';
import 'package:mikipo/src/ui/login/widget/profile_avatar_widget.dart';
import 'package:mikipo/src/util/constants/size_constants.dart';
import 'package:mikipo/src/util/icon/icons_map.dart';
import 'package:provider/provider.dart';

class JobProfileFormWidget extends StatelessWidget {
  static const String _UPDATE_JOB_PROFILE = 'Actualizar tu perfil';
  static const String _JOB_PROFILE_INPUT = 'Indicar tu perfil';
  static const String _LOADING = 'Cargando...';
  static const String _NOT_AVAILABLE = 'No disponible';
  static const String _PICK_SECTION = 'Elige tu seccion';
  static const String _PICK_PROFILE = 'Elige tu perfil';
  static const String _PICK_AREA = 'Elige tu area';
  static const String _PICK_DEPARTMENT = 'Elige tu departamente';

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0,),
        decoration: BoxDecoration(
          color: Palette.ldaColor,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Palette.black.withOpacity(0.5),
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        height: LoginScreen.getFormHeight(viewModel)- 25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ProfileAvatarWidget.AVATAR_SIZE,
                alignment: Alignment.center,
                child: Text(
                  viewModel.isUpdateProfile
                      ? _UPDATE_JOB_PROFILE
                      : _JOB_PROFILE_INPUT,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.white,
                      fontSize: 20.0),
                ),
              ),
              _getHeighProfileInput(viewModel, viewModel.heighProfiles),
              SizedBox(
                height: 10,
              ),
              _getSectionInput(viewModel, viewModel.sections),
              SizedBox(
                height: 10,
              ),
              _getAreaInput(viewModel, viewModel.areas),
              SizedBox(
                height: 10,
              ),
              _getDepartmentInput(
                  viewModel, viewModel.areas, viewModel.departments),
              SizedBox(
                height: 15,
              ),
              getNextButton(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeighProfileInput(
      LoginViewModel viewModel, List<HeighProfile> heighProfiles) {
    return StreamBuilder(
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
    );
  }

  Widget _getAreaInput(LoginViewModel viewModel, List<Area> areas) {
    return StreamBuilder(
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
    );
  }

  Widget _getDepartmentInput(LoginViewModel viewModel, List<Area> areas,
      List<Department> departments) {
    return StreamBuilder(
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
    );
  }

  Widget _getSectionInput(LoginViewModel viewModel, List<Section> sections) {
    return StreamBuilder(
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
    );
  }

  Widget getNextButton(LoginViewModel viewModel) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onSurface: Palette.white,
        primary: Palette.ldaColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          width: 2,
          color: viewModel.isJobProfileFormCompleted
              ? Colors.white
              : Colors.white.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Siguiente',
          style: TextStyle(
              fontSize: 16.0,
              color: viewModel.isJobProfileFormCompleted
                  ? Colors.white
                  : Colors.white.withOpacity(0.5)),
        ),
      ),
      onPressed: viewModel.isJobProfileFormCompleted
          ? () {
              viewModel.submitLoginLogupForm();
            }
          : null,
    );
  }
}
