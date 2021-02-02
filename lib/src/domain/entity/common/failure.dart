import 'package:meta/meta.dart';

@immutable
class Failure {
  final String message;
  Failure({this.message});
}