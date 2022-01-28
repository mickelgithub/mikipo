import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';
import 'package:mikipo/src/util/constants/string_constants.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {

  const factory User(
      {String id,
      String name,
      String surname,
      String email,
      String pass,
      String avatar,
      String remoteAvatar,
      HeighProfile heighProfile,
      Section section,
      Area area,
      Department department,
      bool isEmailVerified,
      String isAcceptedByChef,
      String notificationKey,
      String state}) = _User;

  static const _USER_NOT_AUTHENTICATED_ID = "not_authenticated";

  /*static User notAuthenticatedUser = User(
      id: _USER_NOT_AUTHENTICATED_ID,
      name: StringConstants.EMPTY,
      surname: StringConstants.EMPTY,
      email: StringConstants.EMPTY,
      pass: StringConstants.EMPTY,
      avatar: StringConstants.EMPTY,
      remoteAvatar: StringConstants.EMPTY);*/

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        id: data[UserConstants.USER_ID],
        name: data[UserConstants.NAME],
        surname: data[UserConstants.SURNAME],
        email: data[UserConstants.EMAIL],
        pass: data[UserConstants.PASS],
        avatar: data[UserConstants.AVATAR],
        remoteAvatar: data[UserConstants.REMOTE_AVATAR],
        heighProfile: HeighProfile.fromMap({
          HeighProfile.ID: data[UserConstants.HEIGH_PROFILE][HeighProfile.ID],
          HeighProfile.NAME: data[UserConstants.HEIGH_PROFILE][HeighProfile.NAME],
          HeighProfile.LEVEL: data[UserConstants.HEIGH_PROFILE][HeighProfile.LEVEL],
        }),
        section: Section.fromMap({
          Section.ID: data[UserConstants.SECTION][Section.ID],
          Section.NAME: data[UserConstants.SECTION][Section.NAME],
          Section.ICON: data[UserConstants.SECTION][Section.ICON],
        }),
        area: data[UserConstants.AREA] != null
            ? Area.fromMap({
                Area.ID: data[UserConstants.AREA][Area.ID],
                Area.NAME: data[UserConstants.AREA][Area.NAME],
                Area.ICON: data[UserConstants.AREA][Area.ICON],
              })
            : null,
        department: data[UserConstants.DEPARTMENT] != null
            ? Department.fromMap({
                Department.ID: data[UserConstants.DEPARTMENT][Department.ID],
                Department.NAME: data[UserConstants.DEPARTMENT][Department.NAME],
              })
            : null,
        isEmailVerified: data[UserConstants.IS_EMAIL_VERIFIED],
        isAcceptedByChef: data[UserConstants.IS_ACCEPTED_BY_CHEF],
        notificationKey: data[UserConstants.NOTIFICATION_KEY],
        state: data[UserConstants.STATE]);
  }
}
