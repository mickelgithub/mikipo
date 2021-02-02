// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'organization_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$OrganizationInfoTearOff {
  const _$OrganizationInfoTearOff();

// ignore: unused_element
  _OrganizationInfo call(
      {List<Section> sections, List<HeighProfile> heighProfiles}) {
    return _OrganizationInfo(
      sections: sections,
      heighProfiles: heighProfiles,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $OrganizationInfo = _$OrganizationInfoTearOff();

/// @nodoc
mixin _$OrganizationInfo {
  List<Section> get sections;
  List<HeighProfile> get heighProfiles;

  @JsonKey(ignore: true)
  $OrganizationInfoCopyWith<OrganizationInfo> get copyWith;
}

/// @nodoc
abstract class $OrganizationInfoCopyWith<$Res> {
  factory $OrganizationInfoCopyWith(
          OrganizationInfo value, $Res Function(OrganizationInfo) then) =
      _$OrganizationInfoCopyWithImpl<$Res>;
  $Res call({List<Section> sections, List<HeighProfile> heighProfiles});
}

/// @nodoc
class _$OrganizationInfoCopyWithImpl<$Res>
    implements $OrganizationInfoCopyWith<$Res> {
  _$OrganizationInfoCopyWithImpl(this._value, this._then);

  final OrganizationInfo _value;
  // ignore: unused_field
  final $Res Function(OrganizationInfo) _then;

  @override
  $Res call({
    Object sections = freezed,
    Object heighProfiles = freezed,
  }) {
    return _then(_value.copyWith(
      sections:
          sections == freezed ? _value.sections : sections as List<Section>,
      heighProfiles: heighProfiles == freezed
          ? _value.heighProfiles
          : heighProfiles as List<HeighProfile>,
    ));
  }
}

/// @nodoc
abstract class _$OrganizationInfoCopyWith<$Res>
    implements $OrganizationInfoCopyWith<$Res> {
  factory _$OrganizationInfoCopyWith(
          _OrganizationInfo value, $Res Function(_OrganizationInfo) then) =
      __$OrganizationInfoCopyWithImpl<$Res>;
  @override
  $Res call({List<Section> sections, List<HeighProfile> heighProfiles});
}

/// @nodoc
class __$OrganizationInfoCopyWithImpl<$Res>
    extends _$OrganizationInfoCopyWithImpl<$Res>
    implements _$OrganizationInfoCopyWith<$Res> {
  __$OrganizationInfoCopyWithImpl(
      _OrganizationInfo _value, $Res Function(_OrganizationInfo) _then)
      : super(_value, (v) => _then(v as _OrganizationInfo));

  @override
  _OrganizationInfo get _value => super._value as _OrganizationInfo;

  @override
  $Res call({
    Object sections = freezed,
    Object heighProfiles = freezed,
  }) {
    return _then(_OrganizationInfo(
      sections:
          sections == freezed ? _value.sections : sections as List<Section>,
      heighProfiles: heighProfiles == freezed
          ? _value.heighProfiles
          : heighProfiles as List<HeighProfile>,
    ));
  }
}

/// @nodoc
class _$_OrganizationInfo implements _OrganizationInfo {
  const _$_OrganizationInfo({this.sections, this.heighProfiles});

  @override
  final List<Section> sections;
  @override
  final List<HeighProfile> heighProfiles;

  @override
  String toString() {
    return 'OrganizationInfo(sections: $sections, heighProfiles: $heighProfiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OrganizationInfo &&
            (identical(other.sections, sections) ||
                const DeepCollectionEquality()
                    .equals(other.sections, sections)) &&
            (identical(other.heighProfiles, heighProfiles) ||
                const DeepCollectionEquality()
                    .equals(other.heighProfiles, heighProfiles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sections) ^
      const DeepCollectionEquality().hash(heighProfiles);

  @JsonKey(ignore: true)
  @override
  _$OrganizationInfoCopyWith<_OrganizationInfo> get copyWith =>
      __$OrganizationInfoCopyWithImpl<_OrganizationInfo>(this, _$identity);
}

abstract class _OrganizationInfo implements OrganizationInfo {
  const factory _OrganizationInfo(
      {List<Section> sections,
      List<HeighProfile> heighProfiles}) = _$_OrganizationInfo;

  @override
  List<Section> get sections;
  @override
  List<HeighProfile> get heighProfiles;
  @override
  @JsonKey(ignore: true)
  _$OrganizationInfoCopyWith<_OrganizationInfo> get copyWith;
}
