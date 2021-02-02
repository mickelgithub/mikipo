class Department {

  final int id;
  final String name;

  Department({this.id, this.name});

  factory Department.fromMap(Map<String, dynamic> data) {
    return Department(id: data['id'], name: data['name']);
  }

}