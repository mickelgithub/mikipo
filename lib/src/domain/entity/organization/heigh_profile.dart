class HeighProfile {

  static const String _ID= 'id';
  static const String _NAME= 'name';
  static const String _LEVEL= 'level';

  static const int DIRECTOR_LEVEL= 1;
  static const int AREA_CHEF= 2;
  static const int DEPARTMENT_CHEF= 3;

  final int id;
  final String name;
  final int level;

  HeighProfile({this.id, this.name, this.level});

  factory HeighProfile.fromMap(Map<String, dynamic> data) {
    return HeighProfile(
      id: data[_ID],
      name: data[_NAME],
      level: data[_LEVEL],
    );
  }

}