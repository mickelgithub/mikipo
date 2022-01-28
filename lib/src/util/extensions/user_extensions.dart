import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/util/constants/string_constants.dart';
import 'package:mikipo/src/util/constants/user_constants.dart';
import 'package:mikipo/src/util/extensions/heigh_profile_extensions.dart';
import 'package:mikipo/src/util/extensions/section_extensions.dart';
import 'package:mikipo/src/util/extensions/area_extensions.dart';
import 'package:mikipo/src/util/extensions/department_extensions.dart';

extension UserExtensions on User {
  Map<String, dynamic> toMap() => {
    UserConstants.USER_ID: this.id,
    UserConstants.EMAIL: this.email,
    UserConstants.PASS: this.pass,
    UserConstants.NAME: this.name,
    UserConstants.SURNAME: this.surname,
    UserConstants.AVATAR: this.avatar,
    UserConstants.REMOTE_AVATAR: this.remoteAvatar,
    UserConstants.HEIGH_PROFILE: this.heighProfile.toMap(),
    UserConstants.SECTION: this.section.toMap(),
    UserConstants.AREA: this.area == null ? null : this.area.toMap(),
    UserConstants.DEPARTMENT:
            this.department == null ? null : this.department.toMap(),
    UserConstants.NOTIFICATION_KEY: this.notificationKey,
    UserConstants.IS_ACCEPTED_BY_CHEF: this.isAcceptedByChef,
    UserConstants.IS_EMAIL_VERIFIED: this.isEmailVerified,
    UserConstants.STATE: this.state
      };

  Map<String, dynamic> toChefMap() => {
    UserConstants.USER_ID: this.id,
    UserConstants.HEIGH_PROFILE: this.heighProfile.toMap(),
    UserConstants.SECTION: this.section.toMap(),
    UserConstants.AREA: this.area == null ? null : this.area.toMap(),
    UserConstants.DEPARTMENT:
    this.department == null ? null : this.department.toMap(),
  };

  //TODO change function by get because is more clear
  bool isChef() => heighProfile.isChef();

  bool isDirector() => heighProfile.isDirector();

  bool isAreaChef() => heighProfile.isAreaChef();

  bool isDepartmentChef() => heighProfile.isDepartmentChef();

  bool hasRemoteAvatar() {
    return remoteAvatar != null && remoteAvatar.isNotEmpty;
  }

  bool isConfirmedByChef() => isAcceptedByChef != StringConstants.EMPTY;
  bool isConfirmedPositive() => isAcceptedByChef == StringConstants.YES;
  bool isDeniedByChef() => isAcceptedByChef == StringConstants.NO;

  String fullName() {
    if (surname != null && surname.isNotEmpty) {
      return '$name $surname';
    } else {
      return name;
    }
  }
}
