import 'package:mikipo/src/domain/entity/organization/heigh_profile.dart';

extension HeighProfileExtensions on HeighProfile {

  Map<String, dynamic> toMap() => {
    HeighProfile.ID: this.id,
    HeighProfile.NAME: this.name,
    HeighProfile.LEVEL: this.level
  };

  bool isDirector() => level== HeighProfile.DIRECTOR;

  bool isAreaChef() => level== HeighProfile.AREA_CHEF;

  bool isDepartmentChef() => level== HeighProfile.DEPARTMENT_CHEF;

  bool isChef() => level< HeighProfile.OTHER;

}