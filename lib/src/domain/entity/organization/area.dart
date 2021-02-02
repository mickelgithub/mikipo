import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mikipo/src/domain/entity/organization/department.dart';

part 'area.freezed.dart';

@freezed
abstract class Area with _$Area {

  static const String ID= 'area_id';
  static const String NAME= 'area_name';
  static const String ICON= 'area_icon';
  static const String DEPARTMENTS= 'area_departments';

  const factory Area({int id, String name, String icon, List<Department> departments})= _Area;

  factory Area.fromMap(Map<String, dynamic> data) {
    final departments= <Department>[];
    if (data[DEPARTMENTS]!= null) {
      (data[DEPARTMENTS] as List<dynamic>).forEach((dept) {
        departments.add(Department.fromMap({Department.ID: dept[Department.ID],
          Department.NAME: dept[Department.NAME]}));
      });
    }
    return Area(
      id: data[ID],
      name: data[NAME],
      icon: data[ICON],
      departments: departments
    );
  }
}