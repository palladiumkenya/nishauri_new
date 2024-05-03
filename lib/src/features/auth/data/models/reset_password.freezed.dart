// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PasswordReset _$PasswordResetFromJson(Map<String, dynamic> json) {
  return _PasswordReset.fromJson(json);
}

/// @nodoc
mixin _$PasswordReset {
  String? get id => throw _privateConstructorUsedError;
  String? get current_password => throw _privateConstructorUsedError;
  String? get new_password => throw _privateConstructorUsedError;
  String? get confirm_password => throw _privateConstructorUsedError;
  String? get user_name => throw _privateConstructorUsedError;
  String? get otp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PasswordResetCopyWith<PasswordReset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordResetCopyWith<$Res> {
  factory $PasswordResetCopyWith(
          PasswordReset value, $Res Function(PasswordReset) then) =
      _$PasswordResetCopyWithImpl<$Res, PasswordReset>;
  @useResult
  $Res call(
      {String? id,
      String? current_password,
      String? new_password,
      String? confirm_password,
      String? user_name,
      String? otp});
}

/// @nodoc
class _$PasswordResetCopyWithImpl<$Res, $Val extends PasswordReset>
    implements $PasswordResetCopyWith<$Res> {
  _$PasswordResetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? current_password = freezed,
    Object? new_password = freezed,
    Object? confirm_password = freezed,
    Object? user_name = freezed,
    Object? otp = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      current_password: freezed == current_password
          ? _value.current_password
          : current_password // ignore: cast_nullable_to_non_nullable
              as String?,
      new_password: freezed == new_password
          ? _value.new_password
          : new_password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirm_password: freezed == confirm_password
          ? _value.confirm_password
          : confirm_password // ignore: cast_nullable_to_non_nullable
              as String?,
      user_name: freezed == user_name
          ? _value.user_name
          : user_name // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PasswordResetImplCopyWith<$Res>
    implements $PasswordResetCopyWith<$Res> {
  factory _$$PasswordResetImplCopyWith(
          _$PasswordResetImpl value, $Res Function(_$PasswordResetImpl) then) =
      __$$PasswordResetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? current_password,
      String? new_password,
      String? confirm_password,
      String? user_name,
      String? otp});
}

/// @nodoc
class __$$PasswordResetImplCopyWithImpl<$Res>
    extends _$PasswordResetCopyWithImpl<$Res, _$PasswordResetImpl>
    implements _$$PasswordResetImplCopyWith<$Res> {
  __$$PasswordResetImplCopyWithImpl(
      _$PasswordResetImpl _value, $Res Function(_$PasswordResetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? current_password = freezed,
    Object? new_password = freezed,
    Object? confirm_password = freezed,
    Object? user_name = freezed,
    Object? otp = freezed,
  }) {
    return _then(_$PasswordResetImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      current_password: freezed == current_password
          ? _value.current_password
          : current_password // ignore: cast_nullable_to_non_nullable
              as String?,
      new_password: freezed == new_password
          ? _value.new_password
          : new_password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirm_password: freezed == confirm_password
          ? _value.confirm_password
          : confirm_password // ignore: cast_nullable_to_non_nullable
              as String?,
      user_name: freezed == user_name
          ? _value.user_name
          : user_name // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PasswordResetImpl
    with DiagnosticableTreeMixin
    implements _PasswordReset {
  const _$PasswordResetImpl(
      {this.id,
      this.current_password,
      this.new_password,
      this.confirm_password,
      this.user_name,
      this.otp});

  factory _$PasswordResetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasswordResetImplFromJson(json);

  @override
  final String? id;
  @override
  final String? current_password;
  @override
  final String? new_password;
  @override
  final String? confirm_password;
  @override
  final String? user_name;
  @override
  final String? otp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PasswordReset(id: $id, current_password: $current_password, new_password: $new_password, confirm_password: $confirm_password, user_name: $user_name, otp: $otp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PasswordReset'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('current_password', current_password))
      ..add(DiagnosticsProperty('new_password', new_password))
      ..add(DiagnosticsProperty('confirm_password', confirm_password))
      ..add(DiagnosticsProperty('user_name', user_name))
      ..add(DiagnosticsProperty('otp', otp));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.current_password, current_password) ||
                other.current_password == current_password) &&
            (identical(other.new_password, new_password) ||
                other.new_password == new_password) &&
            (identical(other.confirm_password, confirm_password) ||
                other.confirm_password == confirm_password) &&
            (identical(other.user_name, user_name) ||
                other.user_name == user_name) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, current_password,
      new_password, confirm_password, user_name, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetImplCopyWith<_$PasswordResetImpl> get copyWith =>
      __$$PasswordResetImplCopyWithImpl<_$PasswordResetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PasswordResetImplToJson(
      this,
    );
  }
}

abstract class _PasswordReset implements PasswordReset {
  const factory _PasswordReset(
      {final String? id,
      final String? current_password,
      final String? new_password,
      final String? confirm_password,
      final String? user_name,
      final String? otp}) = _$PasswordResetImpl;

  factory _PasswordReset.fromJson(Map<String, dynamic> json) =
      _$PasswordResetImpl.fromJson;

  @override
  String? get id;
  @override
  String? get current_password;
  @override
  String? get new_password;
  @override
  String? get confirm_password;
  @override
  String? get user_name;
  @override
  String? get otp;
  @override
  @JsonKey(ignore: true)
  _$$PasswordResetImplCopyWith<_$PasswordResetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
