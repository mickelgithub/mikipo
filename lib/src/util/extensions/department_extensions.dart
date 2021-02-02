import 'package:mikipo/src/domain/entity/organization/department.dart';

extension DepartmentExtensions on Department {

  Map<String, dynamic> toMap() => {
    Department.ID: this.id,
    Department.NAME: this.name
  };

}