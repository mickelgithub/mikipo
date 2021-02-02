import 'package:freezed_annotation/freezed_annotation.dart';

part 'department.freezed.dart';

@freezed
abstract class Department with _$Department {

  static const String ID= 'department_id';
  static const String NAME= 'department_name';

  const factory Department({int id, String name})= _Departments;

  factory Department.fromMap(Map<String, dynamic> data) {
    return Department(id: data[ID], name: data[NAME]);
  }

}