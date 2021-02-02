import 'package:path/path.dart' as path;

extension StringExtensions on String {

  String get extension => path.extension(this);

}