// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'heigh_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HeighProfileTearOff {
  const _$HeighProfileTearOff();

// ignore: unused_element
  _HeighProfile call({int id, String name, int level}) {
    return _HeighProfile(
      id: id,
      name: name,
      level: level,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HeighProfile = _$HeighProfileTearOff();

/// @nodoc
mixin _$HeighProfile {
  int get id;
  String get name;
  int get level;

  @JsonKey(ignore: true)
  $HeighProfileCopyWith<HeighProfile> get copyWith;
}

/// @nodoc
abstract class $HeighProfileCopyWith<$Res> {
  factory $HeighProfileCopyWith(
          HeighProfile value, $Res Function(HeighProfile) then) =
      _$HeighProfileCopyWithImpl<$Res>;
  $Res call({int id, String name, int level});
}

/// @nodoc
class _$HeighProfileCopyWithImpl<$Res> implements $HeighProfileCopyWith<$Res> {
  _$HeighProfileCopyWithImpl(this._value, this._then);

  final HeighProfile _value;
  // ignore: unused_field
  final $Res Function(HeighProfile) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object level = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      level: level == freezed ? _value.level : level as int,
    ));
  }
}

/// @nodoc
abstract class _$HeighProfileCopyWith<$Res>
    implements $HeighProfileCopyWith<$Res> {
  factory _$HeighProfileCopyWith(
          _HeighProfile value, $Res Function(_HeighProfile) then) =
      __$HeighProfileCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, int level});
}

/// @nodoc
class __$HeighProfileCopyWithImpl<$Res> extends _$HeighProfileCopyWithImpl<$Res>
    implements _$HeighProfileCopyWith<$Res> {
  __$HeighProfileCopyWithImpl(
      _HeighProfile _value, $Res Function(_HeighProfile) _then)
      : super(_value, (v) => _then(v as _HeighProfile));

  @override
  _HeighProfile get _value => super._value as _HeighProfile;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object level = freezed,
  }) {
    return _then(_HeighProfile(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      level: level == freezed ? _value.level : level as int,
    ));
  }
}

/// @nodoc
class _$_HeighProfile implements _HeighProfile {
  const _$_HeighProfile({this.id, this.name, this.level});

  @override
  final int id;
  @override
  final String name;
  @override
  final int level;

  @override
  String toString() {
    return 'HeighProfile(id: $id, name: $name, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HeighProfile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(level);

  @JsonKey(ignore: true)
  @override
  _$HeighProfileCopyWith<_HeighProfile> get copyWith =>
      __$HeighProfileCopyWithImpl<_HeighProfile>(this, _$identity);
}

abstract class _HeighProfile implements HeighProfile {
  const factory _HeighProfile({int id, String name, int level}) =
      _$_HeighProfile;

  @override
  int get id;
  @override
  String get name;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$HeighProfileCopyWith<_HeighProfile> get copyWith;
}
