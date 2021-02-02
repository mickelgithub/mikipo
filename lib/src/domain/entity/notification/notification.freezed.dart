// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$NotificationTearOff {
  const _$NotificationTearOff();

// ignore: unused_element
  _Notification call(
      {User to,
      User from,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic> extraData}) {
    return _Notification(
      to: to,
      from: from,
      type: type,
      title: title,
      body: body,
      extraData: extraData,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Notification = _$NotificationTearOff();

/// @nodoc
mixin _$Notification {
  User get to;
  User get from;
  NotificationType get type;
  String get title;
  String get body;
  Map<String, dynamic> get extraData;

  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res>;
  $Res call(
      {User to,
      User from,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic> extraData});

  $UserCopyWith<$Res> get to;
  $UserCopyWith<$Res> get from;
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res> implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  final Notification _value;
  // ignore: unused_field
  final $Res Function(Notification) _then;

  @override
  $Res call({
    Object to = freezed,
    Object from = freezed,
    Object type = freezed,
    Object title = freezed,
    Object body = freezed,
    Object extraData = freezed,
  }) {
    return _then(_value.copyWith(
      to: to == freezed ? _value.to : to as User,
      from: from == freezed ? _value.from : from as User,
      type: type == freezed ? _value.type : type as NotificationType,
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      extraData: extraData == freezed
          ? _value.extraData
          : extraData as Map<String, dynamic>,
    ));
  }

  @override
  $UserCopyWith<$Res> get to {
    if (_value.to == null) {
      return null;
    }
    return $UserCopyWith<$Res>(_value.to, (value) {
      return _then(_value.copyWith(to: value));
    });
  }

  @override
  $UserCopyWith<$Res> get from {
    if (_value.from == null) {
      return null;
    }
    return $UserCopyWith<$Res>(_value.from, (value) {
      return _then(_value.copyWith(from: value));
    });
  }
}

/// @nodoc
abstract class _$NotificationCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(
          _Notification value, $Res Function(_Notification) then) =
      __$NotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {User to,
      User from,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic> extraData});

  @override
  $UserCopyWith<$Res> get to;
  @override
  $UserCopyWith<$Res> get from;
}

/// @nodoc
class __$NotificationCopyWithImpl<$Res> extends _$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(
      _Notification _value, $Res Function(_Notification) _then)
      : super(_value, (v) => _then(v as _Notification));

  @override
  _Notification get _value => super._value as _Notification;

  @override
  $Res call({
    Object to = freezed,
    Object from = freezed,
    Object type = freezed,
    Object title = freezed,
    Object body = freezed,
    Object extraData = freezed,
  }) {
    return _then(_Notification(
      to: to == freezed ? _value.to : to as User,
      from: from == freezed ? _value.from : from as User,
      type: type == freezed ? _value.type : type as NotificationType,
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      extraData: extraData == freezed
          ? _value.extraData
          : extraData as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
class _$_Notification implements _Notification {
  const _$_Notification(
      {this.to, this.from, this.type, this.title, this.body, this.extraData});

  @override
  final User to;
  @override
  final User from;
  @override
  final NotificationType type;
  @override
  final String title;
  @override
  final String body;
  @override
  final Map<String, dynamic> extraData;

  @override
  String toString() {
    return 'Notification(to: $to, from: $from, type: $type, title: $title, body: $body, extraData: $extraData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Notification &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.extraData, extraData) ||
                const DeepCollectionEquality()
                    .equals(other.extraData, extraData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(extraData);

  @JsonKey(ignore: true)
  @override
  _$NotificationCopyWith<_Notification> get copyWith =>
      __$NotificationCopyWithImpl<_Notification>(this, _$identity);
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {User to,
      User from,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic> extraData}) = _$_Notification;

  @override
  User get to;
  @override
  User get from;
  @override
  NotificationType get type;
  @override
  String get title;
  @override
  String get body;
  @override
  Map<String, dynamic> get extraData;
  @override
  @JsonKey(ignore: true)
  _$NotificationCopyWith<_Notification> get copyWith;
}
