import 'package:meta/meta.dart';

@immutable
class User {

  static const _USER_NOT_AUTHENTICATED_ID= "not_authenticated";

  static const String NAME= 'name';
  static const String SURNAME= 'surname';
  static const String USER_ID= 'userId';
  static const String EMAIL= 'email';
  static const String PASS= "pass";
  static const String AVATAR= 'avatar';
  static const String REMOTE_AVATAR= 'remote_avatar';

  final String userId;
  final String name;
  final String surname;
  final String email;
  final String pass;
  final String avatar;
  final String remoteAvatar;

  static User notAuthenticatedUser= User(userId: _USER_NOT_AUTHENTICATED_ID, name: '', surname: '', email: '', pass: '', avatar: '', remoteAvatar: '');

  User({this.userId, this.name, this.surname, this.email, this.pass, this.avatar, this.remoteAvatar});

}