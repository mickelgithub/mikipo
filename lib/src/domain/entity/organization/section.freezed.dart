// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SectionTearOff {
  const _$SectionTearOff();

// ignore: unused_element
  _Section call({int id, String name, String icon, List<Area> areas}) {
    return _Section(
      id: id,
      name: name,
      icon: icon,
      areas: areas,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Section = _$SectionTearOff();

/// @nodoc
mixin _$Section {
  int get id;
  String get name;
  String get icon;
  List<Area> get areas;

  @JsonKey(ignore: true)
  $SectionCopyWith<Section> get copyWith;
}

/// @nodoc
abstract class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) then) =
      _$SectionCopyWithImpl<$Res>;
  $Res call({int id, String name, String icon, List<Area> areas});
}

/// @nodoc
class _$SectionCopyWithImpl<$Res> implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._value, this._then);

  final Section _value;
  // ignore: unused_field
  final $Res Function(Section) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object icon = freezed,
    Object areas = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      icon: icon == freezed ? _value.icon : icon as String,
      areas: areas == freezed ? _value.areas : areas as List<Area>,
    ));
  }
}

/// @nodoc
abstract class _$SectionCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$SectionCopyWith(_Section value, $Res Function(_Section) then) =
      __$SectionCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, String icon, List<Area> areas});
}

/// @nodoc
class __$SectionCopyWithImpl<$Res> extends _$SectionCopyWithImpl<$Res>
    implements _$SectionCopyWith<$Res> {
  __$SectionCopyWithImpl(_Section _value, $Res Function(_Section) _then)
      : super(_value, (v) => _then(v as _Section));

  @override
  _Section get _value => super._value as _Section;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object icon = freezed,
    Object areas = freezed,
  }) {
    return _then(_Section(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      icon: icon == freezed ? _value.icon : icon as String,
      areas: areas == freezed ? _value.areas : areas as List<Area>,
    ));
  }
}

/// @nodoc
class _$_Section implements _Section {
  const _$_Section({this.id, this.name, this.icon, this.areas});

  @override
  final int id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final List<Area> areas;

  @override
  String toString() {
    return 'Section(id: $id, name: $name, icon: $icon, areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Section &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.areas, areas) ||
                const DeepCollectionEquality().equals(other.areas, areas)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(areas);

  @JsonKey(ignore: true)
  @override
  _$SectionCopyWith<_Section> get copyWith =>
      __$SectionCopyWithImpl<_Section>(this, _$identity);
}

abstract class _Section implements Section {
  const factory _Section({int id, String name, String icon, List<Area> areas}) =
      _$_Section;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  List<Area> get areas;
  @override
  @JsonKey(ignore: true)
  _$SectionCopyWith<_Section> get copyWith;
}
