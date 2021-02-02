// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'department.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DepartmentTearOff {
  const _$DepartmentTearOff();

// ignore: unused_element
  _Departments call({int id, String name}) {
    return _Departments(
      id: id,
      name: name,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Department = _$DepartmentTearOff();

/// @nodoc
mixin _$Department {
  int get id;
  String get name;

  @JsonKey(ignore: true)
  $DepartmentCopyWith<Department> get copyWith;
}

/// @nodoc
abstract class $DepartmentCopyWith<$Res> {
  factory $DepartmentCopyWith(
          Department value, $Res Function(Department) then) =
      _$DepartmentCopyWithImpl<$Res>;
  $Res call({int id, String name});
}

/// @nodoc
class _$DepartmentCopyWithImpl<$Res> implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._value, this._then);

  final Department _value;
  // ignore: unused_field
  final $Res Function(Department) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

/// @nodoc
abstract class _$DepartmentsCopyWith<$Res>
    implements $DepartmentCopyWith<$Res> {
  factory _$DepartmentsCopyWith(
          _Departments value, $Res Function(_Departments) then) =
      __$DepartmentsCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name});
}

/// @nodoc
class __$DepartmentsCopyWithImpl<$Res> extends _$DepartmentCopyWithImpl<$Res>
    implements _$DepartmentsCopyWith<$Res> {
  __$DepartmentsCopyWithImpl(
      _Departments _value, $Res Function(_Departments) _then)
      : super(_value, (v) => _then(v as _Departments));

  @override
  _Departments get _value => super._value as _Departments;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_Departments(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

/// @nodoc
class _$_Departments implements _Departments {
  const _$_Departments({this.id, this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'Department(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Departments &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$DepartmentsCopyWith<_Departments> get copyWith =>
      __$DepartmentsCopyWithImpl<_Departments>(this, _$identity);
}

abstract class _Departments implements Department {
  const factory _Departments({int id, String name}) = _$_Departments;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$DepartmentsCopyWith<_Departments> get copyWith;
}
