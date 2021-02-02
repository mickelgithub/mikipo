import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/domain/entity/organization/section.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {

  const factory User({String id, String name, String surname, String email,
    String pass, String avatar, String remoteAvatar, HeighProfile heighProfile,
    Section section, Area area, Department department,
    bool isEmailVerified, bool isAcceptedByChef, String notificationKey,
  String state})= _User;

  static const _USER_NOT_AUTHENTICATED_ID= "not_authenticated";

  static const String NAME= 'user_name';
  static const String SURNAME= 'user_surname';
  static const String USER_ID= 'user_id';
  static const String EMAIL= 'user_email';
  static const String PASS= "user_pass";
  static const String AVATAR= 'user_avatar';
  static const String REMOTE_AVATAR= 'user_remote_avatar';
  static const String HEIGH_PROFILE= 'user_heigh_profile';
  static const String SECTION= 'user_section';
  static const String AREA= 'user_area';
  static const String DEPARTMENT= 'user_department';
  static const String IS_EMAIL_VERIFIED= 'user_is_email_verified';
  static const String NOTIFICATION_KEY= 'user_notification_key';
  static const String IS_ACCEPTED_BY_CHEF= 'user_is_accepted_by_chef';
  static const String STATE= 'user_state';

  static const String STATE_ACTIVE= 'active';
  static const String STATE_DISABLED= 'disabled';
  static const String STATE_DISCHARGED= 'discharged';

  static const String EMPTY= '';

  static User notAuthenticatedUser= User(id: _USER_NOT_AUTHENTICATED_ID,
      name: EMPTY, surname: EMPTY, email: EMPTY, pass: EMPTY, avatar: EMPTY,
      remoteAvatar: EMPTY);

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data[USER_ID],
      name: data[NAME],
      surname: data[SURNAME],
      email: data[EMAIL],
      pass: data[PASS],
      avatar: data[AVATAR],
      remoteAvatar: data[REMOTE_AVATAR],
      heighProfile: HeighProfile.fromMap({
        HeighProfile.ID:data[HEIGH_PROFILE][HeighProfile.ID],
        HeighProfile.NAME:data[HEIGH_PROFILE][HeighProfile.NAME],
        HeighProfile.LEVEL:data[HEIGH_PROFILE][HeighProfile.LEVEL],
      }),
      section: Section.fromMap({
        Section.ID:data[SECTION][Section.ID],
        Section.NAME:data[SECTION][Section.NAME],
        Section.ICON:data[SECTION][Section.ICON],
      }),
      area: data[AREA]!= null ? Area.fromMap({
        Area.ID:data[AREA][Area.ID],
        Area.NAME:data[AREA][Area.NAME],
        Area.ICON:data[AREA][Area.ICON],
      }) : null,
      department: data[DEPARTMENT]!= null ? Department.fromMap({
        Department.ID:data[DEPARTMENT][Department.ID],
        Department.NAME:data[DEPARTMENT][Department.NAME],
      }) : null,
      isEmailVerified: data[IS_EMAIL_VERIFIED],
      isAcceptedByChef: data[IS_ACCEPTED_BY_CHEF],
      notificationKey: data[NOTIFICATION_KEY],
      state: data[STATE]
    );
  }

}