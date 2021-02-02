import 'package:mikipo/src/domain/entity/auth/user.dart';
import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';
import 'package:mikipo/src/util/extensions/heigh_profile_extensions.dart';
import 'package:mikipo/src/util/extensions/section_extensions.dart';
import 'package:mikipo/src/util/extensions/area_extensions.dart';
import 'package:mikipo/src/util/extensions/department_extensions.dart';

extension UserExtensions on User {

  Map<String, dynamic> toMap() => {
    User.USER_ID: this.id,
    User.EMAIL: this.email,
    User.PASS: this.pass,
    User.NAME: this.name,
    User.SURNAME: this.surname,
    User.AVATAR: this.avatar,
    User.REMOTE_AVATAR: this.remoteAvatar,
    User.HEIGH_PROFILE: this.heighProfile.toMap(),
    User.SECTION: this.section.toMap(),
    User.AREA: this.area== null ? null : this.area.toMap(),
    User.DEPARTMENT: this.department== null ? null : this.department.toMap(),
    User.NOTIFICATION_KEY: this.notificationKey,
    User.IS_ACCEPTED_BY_CHEF: this.isAcceptedByChef,
    User.IS_EMAIL_VERIFIED: this.isEmailVerified,
    User.STATE: this.state
  };

  bool isChef() => heighProfile.isChef();

  bool isDirector() => heighProfile.isDirector();

  bool isAreaChef() => heighProfile.isAreaChef();

  bool isDepartmentChef() => heighProfile.isDepartmentChef();

  bool hasRemoteAvatar() {
    return remoteAvatar!= null && remoteAvatar.isNotEmpty;
  }

  String fullName() {
    if (surname!= null && surname.isNotEmpty) {
      return '${name} ${surname}';
    } else {
      return name;
    }
  }

}