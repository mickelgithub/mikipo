// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

// ignore: unused_element
  _User call(
      {String id,
      String name,
      String surname,
      String email,
      String pass,
      String avatar,
      String remoteAvatar,
      HeighProfile heighProfile,
      Section section,
      Area area,
      Department department,
      bool isEmailVerified,
      String isAcceptedByChef,
      String notificationKey,
      String state}) {
    return _User(
      id: id,
      name: name,
      surname: surname,
      email: email,
      pass: pass,
      avatar: avatar,
      remoteAvatar: remoteAvatar,
      heighProfile: heighProfile,
      section: section,
      area: area,
      department: department,
      isEmailVerified: isEmailVerified,
      isAcceptedByChef: isAcceptedByChef,
      notificationKey: notificationKey,
      state: state,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get id;
  String get name;
  String get surname;
  String get email;
  String get pass;
  String get avatar;
  String get remoteAvatar;
  HeighProfile get heighProfile;
  Section get section;
  Area get area;
  Department get department;
  bool get isEmailVerified;
  String get isAcceptedByChef;
  String get notificationKey;
  String get state;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String surname,
      String email,
      String pass,
      String avatar,
      String remoteAvatar,
      HeighProfile heighProfile,
      Section section,
      Area area,
      Department department,
      bool isEmailVerified,
      String isAcceptedByChef,
      String notificationKey,
      String state});

  $HeighProfileCopyWith<$Res> get heighProfile;
  $SectionCopyWith<$Res> get section;
  $AreaCopyWith<$Res> get area;
  $DepartmentCopyWith<$Res> get department;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object surname = freezed,
    Object email = freezed,
    Object pass = freezed,
    Object avatar = freezed,
    Object remoteAvatar = freezed,
    Object heighProfile = freezed,
    Object section = freezed,
    Object area = freezed,
    Object department = freezed,
    Object isEmailVerified = freezed,
    Object isAcceptedByChef = freezed,
    Object notificationKey = freezed,
    Object state = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      surname: surname == freezed ? _value.surname : surname as String,
      email: email == freezed ? _value.email : email as String,
      pass: pass == freezed ? _value.pass : pass as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      remoteAvatar: remoteAvatar == freezed
          ? _value.remoteAvatar
          : remoteAvatar as String,
      heighProfile: heighProfile == freezed
          ? _value.heighProfile
          : heighProfile as HeighProfile,
      section: section == freezed ? _value.section : section as Section,
      area: area == freezed ? _value.area : area as Area,
      department:
          department == freezed ? _value.department : department as Department,
      isEmailVerified: isEmailVerified == freezed
          ? _value.isEmailVerified
          : isEmailVerified as bool,
      isAcceptedByChef: isAcceptedByChef == freezed
          ? _value.isAcceptedByChef
          : isAcceptedByChef as String,
      notificationKey: notificationKey == freezed
          ? _value.notificationKey
          : notificationKey as String,
      state: state == freezed ? _value.state : state as String,
    ));
  }

  @override
  $HeighProfileCopyWith<$Res> get heighProfile {
    if (_value.heighProfile == null) {
      return null;
    }
    return $HeighProfileCopyWith<$Res>(_value.heighProfile, (value) {
      return _then(_value.copyWith(heighProfile: value));
    });
  }

  @override
  $SectionCopyWith<$Res> get section {
    if (_value.section == null) {
      return null;
    }
    return $SectionCopyWith<$Res>(_value.section, (value) {
      return _then(_value.copyWith(section: value));
    });
  }

  @override
  $AreaCopyWith<$Res> get area {
    if (_value.area == null) {
      return null;
    }
    return $AreaCopyWith<$Res>(_value.area, (value) {
      return _then(_value.copyWith(area: value));
    });
  }

  @override
  $DepartmentCopyWith<$Res> get department {
    if (_value.department == null) {
      return null;
    }
    return $DepartmentCopyWith<$Res>(_value.department, (value) {
      return _then(_value.copyWith(department: value));
    });
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String surname,
      String email,
      String pass,
      String avatar,
      String remoteAvatar,
      HeighProfile heighProfile,
      Section section,
      Area area,
      Department department,
      bool isEmailVerified,
      String isAcceptedByChef,
      String notificationKey,
      String state});

  @override
  $HeighProfileCopyWith<$Res> get heighProfile;
  @override
  $SectionCopyWith<$Res> get section;
  @override
  $AreaCopyWith<$Res> get area;
  @override
  $DepartmentCopyWith<$Res> get department;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object surname = freezed,
    Object email = freezed,
    Object pass = freezed,
    Object avatar = freezed,
    Object remoteAvatar = freezed,
    Object heighProfile = freezed,
    Object section = freezed,
    Object area = freezed,
    Object department = freezed,
    Object isEmailVerified = freezed,
    Object isAcceptedByChef = freezed,
    Object notificationKey = freezed,
    Object state = freezed,
  }) {
    return _then(_User(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      surname: surname == freezed ? _value.surname : surname as String,
      email: email == freezed ? _value.email : email as String,
      pass: pass == freezed ? _value.pass : pass as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      remoteAvatar: remoteAvatar == freezed
          ? _value.remoteAvatar
          : remoteAvatar as String,
      heighProfile: heighProfile == freezed
          ? _value.heighProfile
          : heighProfile as HeighProfile,
      section: section == freezed ? _value.section : section as Section,
      area: area == freezed ? _value.area : area as Area,
      department:
          department == freezed ? _value.department : department as Department,
      isEmailVerified: isEmailVerified == freezed
          ? _value.isEmailVerified
          : isEmailVerified as bool,
      isAcceptedByChef: isAcceptedByChef == freezed
          ? _value.isAcceptedByChef
          : isAcceptedByChef as String,
      notificationKey: notificationKey == freezed
          ? _value.notificationKey
          : notificationKey as String,
      state: state == freezed ? _value.state : state as String,
    ));
  }
}

/// @nodoc
class _$_User implements _User {
  const _$_User(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.pass,
      this.avatar,
      this.remoteAvatar,
      this.heighProfile,
      this.section,
      this.area,
      this.department,
      this.isEmailVerified,
      this.isAcceptedByChef,
      this.notificationKey,
      this.state});

  @override
  final String id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  @override
  final String pass;
  @override
  final String avatar;
  @override
  final String remoteAvatar;
  @override
  final HeighProfile heighProfile;
  @override
  final Section section;
  @override
  final Area area;
  @override
  final Department department;
  @override
  final bool isEmailVerified;
  @override
  final String isAcceptedByChef;
  @override
  final String notificationKey;
  @override
  final String state;

  @override
  String toString() {
    return 'User(id: $id, name: $name, surname: $surname, email: $email, pass: $pass, avatar: $avatar, remoteAvatar: $remoteAvatar, heighProfile: $heighProfile, section: $section, area: $area, department: $department, isEmailVerified: $isEmailVerified, isAcceptedByChef: $isAcceptedByChef, notificationKey: $notificationKey, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.surname, surname) ||
                const DeepCollectionEquality()
                    .equals(other.surname, surname)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.pass, pass) ||
                const DeepCollectionEquality().equals(other.pass, pass)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.remoteAvatar, remoteAvatar) ||
                const DeepCollectionEquality()
                    .equals(other.remoteAvatar, remoteAvatar)) &&
            (identical(other.heighProfile, heighProfile) ||
                const DeepCollectionEquality()
                    .equals(other.heighProfile, heighProfile)) &&
            (identical(other.section, section) ||
                const DeepCollectionEquality()
                    .equals(other.section, section)) &&
            (identical(other.area, area) ||
                const DeepCollectionEquality().equals(other.area, area)) &&
            (identical(other.department, department) ||
                const DeepCollectionEquality()
                    .equals(other.department, department)) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                const DeepCollectionEquality()
                    .equals(other.isEmailVerified, isEmailVerified)) &&
            (identical(other.isAcceptedByChef, isAcceptedByChef) ||
                const DeepCollectionEquality()
                    .equals(other.isAcceptedByChef, isAcceptedByChef)) &&
            (identical(other.notificationKey, notificationKey) ||
                const DeepCollectionEquality()
                    .equals(other.notificationKey, notificationKey)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(surname) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(pass) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(remoteAvatar) ^
      const DeepCollectionEquality().hash(heighProfile) ^
      const DeepCollectionEquality().hash(section) ^
      const DeepCollectionEquality().hash(area) ^
      const DeepCollectionEquality().hash(department) ^
      const DeepCollectionEquality().hash(isEmailVerified) ^
      const DeepCollectionEquality().hash(isAcceptedByChef) ^
      const DeepCollectionEquality().hash(notificationKey) ^
      const DeepCollectionEquality().hash(state);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {String id,
      String name,
      String surname,
      String email,
      String pass,
      String avatar,
      String remoteAvatar,
      HeighProfile heighProfile,
      Section section,
      Area area,
      Department department,
      bool isEmailVerified,
      String isAcceptedByChef,
      String notificationKey,
      String state}) = _$_User;

  @override
  String get id;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get email;
  @override
  String get pass;
  @override
  String get avatar;
  @override
  String get remoteAvatar;
  @override
  HeighProfile get heighProfile;
  @override
  Section get section;
  @override
  Area get area;
  @override
  Department get department;
  @override
  bool get isEmailVerified;
  @override
  String get isAcceptedByChef;
  @override
  String get notificationKey;
  @override
  String get state;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith;
}
