// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) {
  return _PersonalInfo.fromJson(json);
}

/// @nodoc
mixin _$PersonalInfo {
  String? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get regimen => throw _privateConstructorUsedError;
  String? get appointment_datetime => throw _privateConstructorUsedError;
  String? get viral_load => throw _privateConstructorUsedError;
  String? get viral_load_datetime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalInfoCopyWith<PersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalInfoCopyWith<$Res> {
  factory $PersonalInfoCopyWith(
          PersonalInfo value, $Res Function(PersonalInfo) then) =
      _$PersonalInfoCopyWithImpl<$Res, PersonalInfo>;
  @useResult
  $Res call(
      {String? gender,
      int? age,
      String? regimen,
      String? appointment_datetime,
      String? viral_load,
      String? viral_load_datetime});
}

/// @nodoc
class _$PersonalInfoCopyWithImpl<$Res, $Val extends PersonalInfo>
    implements $PersonalInfoCopyWith<$Res> {
  _$PersonalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = freezed,
    Object? age = freezed,
    Object? regimen = freezed,
    Object? appointment_datetime = freezed,
    Object? viral_load = freezed,
    Object? viral_load_datetime = freezed,
  }) {
    return _then(_value.copyWith(
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      regimen: freezed == regimen
          ? _value.regimen
          : regimen // ignore: cast_nullable_to_non_nullable
              as String?,
      appointment_datetime: freezed == appointment_datetime
          ? _value.appointment_datetime
          : appointment_datetime // ignore: cast_nullable_to_non_nullable
              as String?,
      viral_load: freezed == viral_load
          ? _value.viral_load
          : viral_load // ignore: cast_nullable_to_non_nullable
              as String?,
      viral_load_datetime: freezed == viral_load_datetime
          ? _value.viral_load_datetime
          : viral_load_datetime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalInfoImplCopyWith<$Res>
    implements $PersonalInfoCopyWith<$Res> {
  factory _$$PersonalInfoImplCopyWith(
          _$PersonalInfoImpl value, $Res Function(_$PersonalInfoImpl) then) =
      __$$PersonalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? gender,
      int? age,
      String? regimen,
      String? appointment_datetime,
      String? viral_load,
      String? viral_load_datetime});
}

/// @nodoc
class __$$PersonalInfoImplCopyWithImpl<$Res>
    extends _$PersonalInfoCopyWithImpl<$Res, _$PersonalInfoImpl>
    implements _$$PersonalInfoImplCopyWith<$Res> {
  __$$PersonalInfoImplCopyWithImpl(
      _$PersonalInfoImpl _value, $Res Function(_$PersonalInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = freezed,
    Object? age = freezed,
    Object? regimen = freezed,
    Object? appointment_datetime = freezed,
    Object? viral_load = freezed,
    Object? viral_load_datetime = freezed,
  }) {
    return _then(_$PersonalInfoImpl(
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      regimen: freezed == regimen
          ? _value.regimen
          : regimen // ignore: cast_nullable_to_non_nullable
              as String?,
      appointment_datetime: freezed == appointment_datetime
          ? _value.appointment_datetime
          : appointment_datetime // ignore: cast_nullable_to_non_nullable
              as String?,
      viral_load: freezed == viral_load
          ? _value.viral_load
          : viral_load // ignore: cast_nullable_to_non_nullable
              as String?,
      viral_load_datetime: freezed == viral_load_datetime
          ? _value.viral_load_datetime
          : viral_load_datetime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalInfoImpl implements _PersonalInfo {
  const _$PersonalInfoImpl(
      {this.gender,
      this.age,
      this.regimen,
      this.appointment_datetime,
      this.viral_load,
      this.viral_load_datetime});

  factory _$PersonalInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalInfoImplFromJson(json);

  @override
  final String? gender;
  @override
  final int? age;
  @override
  final String? regimen;
  @override
  final String? appointment_datetime;
  @override
  final String? viral_load;
  @override
  final String? viral_load_datetime;

  @override
  String toString() {
    return 'PersonalInfo(gender: $gender, age: $age, regimen: $regimen, appointment_datetime: $appointment_datetime, viral_load: $viral_load, viral_load_datetime: $viral_load_datetime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalInfoImpl &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.regimen, regimen) || other.regimen == regimen) &&
            (identical(other.appointment_datetime, appointment_datetime) ||
                other.appointment_datetime == appointment_datetime) &&
            (identical(other.viral_load, viral_load) ||
                other.viral_load == viral_load) &&
            (identical(other.viral_load_datetime, viral_load_datetime) ||
                other.viral_load_datetime == viral_load_datetime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gender, age, regimen,
      appointment_datetime, viral_load, viral_load_datetime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      __$$PersonalInfoImplCopyWithImpl<_$PersonalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalInfoImplToJson(
      this,
    );
  }
}

abstract class _PersonalInfo implements PersonalInfo {
  const factory _PersonalInfo(
      {final String? gender,
      final int? age,
      final String? regimen,
      final String? appointment_datetime,
      final String? viral_load,
      final String? viral_load_datetime}) = _$PersonalInfoImpl;

  factory _PersonalInfo.fromJson(Map<String, dynamic> json) =
      _$PersonalInfoImpl.fromJson;

  @override
  String? get gender;
  @override
  int? get age;
  @override
  String? get regimen;
  @override
  String? get appointment_datetime;
  @override
  String? get viral_load;
  @override
  String? get viral_load_datetime;
  @override
  @JsonKey(ignore: true)
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
