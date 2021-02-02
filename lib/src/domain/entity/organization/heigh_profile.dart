import 'package:freezed_annotation/freezed_annotation.dart';

part 'heigh_profile.freezed.dart';

@freezed
abstract class HeighProfile with _$HeighProfile {

  static const String ID= 'heigh_profile_id';
  static const String NAME= 'heigh_profile_name';
  static const String LEVEL= 'heigh_profile_level';

  static const int DIRECTOR= 1;
  static const int AREA_CHEF= 2;
  static const int DEPARTMENT_CHEF= 3;
  static const int OTHER= 4;

  const factory HeighProfile({int id, String name, int level})= _HeighProfile;

  factory HeighProfile.fromMap(Map<String, dynamic> data) {
    return HeighProfile(
      id: data[ID],
      name: data[NAME],
      level: data[LEVEL],
    );
  }

}