class EmailUtil {

  static const String _AT= '@';
  static const String _DOT= '.';

  //name in the fisrt position
  //surname in the second
  static List<String> getNameAndSurname(String email) {
    String surname;
    final result= email.split(_AT);
    String name= result[0];
    if (name.contains('.')) {
      final fullNameList= name.split(_DOT);
      name= fullNameList[0];
      surname= fullNameList[1];
    }
    return surname== null ? [name] : [name, surname];
  }
}