import 'area.dart';

class Section {

  final id;
  final String name;
  final String icon;
  final List<Area> areas;

  Section({this.id, this.name, this.icon, this.areas});

  factory Section.fromMap(Map<String, dynamic> data) {
    final areas= <Area>[];
    if (data['areas']!= null) {
      (data['areas'] as List<dynamic>).forEach((e) => areas.add(Area.fromMap({'id': e['id'], 'name': e['name'], 'icon': e['icon'], 'departments': e['departments']})));
    }
    return Section(
        id: data['id'],
        name: data['name'],
        icon: data['icon'],
        areas: areas
    );
  }
}