import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/organization/area.dart';

part 'section.freezed.dart';

@freezed
abstract class Section with _$Section {

  static const String ID= 'section_id';
  static const String NAME= 'section_name';
  static const String ICON= 'section_icon';
  static const String AREAS= 'section_areas';

  const factory Section({int id, String name, String icon, List<Area> areas})= _Section;

  factory Section.fromMap(Map<String, dynamic> data) {
    final areas= <Area>[];
    if (data[AREAS]!= null) {
      (data[AREAS] as List<dynamic>).forEach((e) =>
          areas.add(Area.fromMap({Area.ID: e[Area.ID],
            Area.NAME: e[Area.NAME],
            Area.ICON: e[Area.ICON],
            Area.DEPARTMENTS: e[Area.DEPARTMENTS]})));
    }
    return Section(
        id: data[ID],
        name: data[NAME],
        icon: data[ICON],
        areas: areas
    );
  }
}