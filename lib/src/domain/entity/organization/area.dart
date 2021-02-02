

import 'package:mikipo/src/domain/entities/organization/department.dart';

class Area {

  final int id;
  final String name;
  final String icon;
  final List<Department> departments;

  Area({this.id, this.name, this.icon, this.departments});

  factory Area.fromMap(Map<String, dynamic> data) {
    final departments= <Department>[];
    if (data['departments']!= null) {
      (data['departments'] as List<dynamic>).forEach((dept) {
        departments.add(Department.fromMap({'id': dept['id'], 'name': dept['name']}));
      });
    }
    return Area(
      id: data['id'],
      name: data['name'],
      icon: data['icon'],
      departments: departments
    );
  }
}