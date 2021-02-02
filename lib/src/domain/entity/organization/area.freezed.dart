// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AreaTearOff {
  const _$AreaTearOff();

// ignore: unused_element
  _Area call({int id, String name, String icon, List<Department> departments}) {
    return _Area(
      id: id,
      name: name,
      icon: icon,
      departments: departments,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Area = _$AreaTearOff();

/// @nodoc
mixin _$Area {
  int get id;
  String get name;
  String get icon;
  List<Department> get departments;

  @JsonKey(ignore: true)
  $AreaCopyWith<Area> get copyWith;
}

/// @nodoc
abstract class $AreaCopyWith<$Res> {
  factory $AreaCopyWith(Area value, $Res Function(Area) then) =
      _$AreaCopyWithImpl<$Res>;
  $Res call({int id, String name, String icon, List<Department> departments});
}

/// @nodoc
class _$AreaCopyWithImpl<$Res> implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._value, this._then);

  final Area _value;
  // ignore: unused_field
  final $Res Function(Area) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object icon = freezed,
    Object departments = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      icon: icon == freezed ? _value.icon : icon as String,
      departments: departments == freezed
          ? _value.departments
          : departments as List<Department>,
    ));
  }
}

/// @nodoc
abstract class _$AreaCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$AreaCopyWith(_Area value, $Res Function(_Area) then) =
      __$AreaCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, String icon, List<Department> departments});
}

/// @nodoc
class __$AreaCopyWithImpl<$Res> extends _$AreaCopyWithImpl<$Res>
    implements _$AreaCopyWith<$Res> {
  __$AreaCopyWithImpl(_Area _value, $Res Function(_Area) _then)
      : super(_value, (v) => _then(v as _Area));

  @override
  _Area get _value => super._value as _Area;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object icon = freezed,
    Object departments = freezed,
  }) {
    return _then(_Area(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      icon: icon == freezed ? _value.icon : icon as String,
      departments: departments == freezed
          ? _value.departments
          : departments as List<Department>,
    ));
  }
}

/// @nodoc
class _$_Area implements _Area {
  const _$_Area({this.id, this.name, this.icon, this.departments});

  @override
  final int id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final List<Department> departments;

  @override
  String toString() {
    return 'Area(id: $id, name: $name, icon: $icon, departments: $departments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Area &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.departments, departments) ||
                const DeepCollectionEquality()
                    .equals(other.departments, departments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(departments);

  @JsonKey(ignore: true)
  @override
  _$AreaCopyWith<_Area> get copyWith =>
      __$AreaCopyWithImpl<_Area>(this, _$identity);
}

abstract class _Area implements Area {
  const factory _Area(
      {int id,
      String name,
      String icon,
      List<Department> departments}) = _$_Area;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  List<Department> get departments;
  @override
  @JsonKey(ignore: true)
  _$AreaCopyWith<_Area> get copyWith;
}
