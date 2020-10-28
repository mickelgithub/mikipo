import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {

  static const USER_NOT_AUTHENTICATED= "not_authenticated";

  const factory User({
    @required String id,
  }) = _User;

  static User notAuthenticatedUser= User(id: USER_NOT_AUTHENTICATED);

}