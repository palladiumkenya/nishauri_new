// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blood_pressure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) {
  return _BloodPressure.fromJson(json);
}

/// @nodoc
mixin _$BloodPressure {
  double get systolic => throw _privateConstructorUsedError;
  double get diastolic => throw _privateConstructorUsedError;
  double get pulse_rate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get date_time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BloodPressureCopyWith<BloodPressure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BloodPressureCopyWith<$Res> {
  factory $BloodPressureCopyWith(
          BloodPressure value, $Res Function(BloodPressure) then) =
      _$BloodPressureCopyWithImpl<$Res, BloodPressure>;
  @useResult
  $Res call(
      {double systolic,
      double diastolic,
      double pulse_rate,
      String? notes,
      DateTime date_time});
}

/// @nodoc
class _$BloodPressureCopyWithImpl<$Res, $Val extends BloodPressure>
    implements $BloodPressureCopyWith<$Res> {
  _$BloodPressureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systolic = null,
    Object? diastolic = null,
    Object? pulse_rate = null,
    Object? notes = freezed,
    Object? date_time = null,
  }) {
    return _then(_value.copyWith(
      systolic: null == systolic
          ? _value.systolic
          : systolic // ignore: cast_nullable_to_non_nullable
              as double,
      diastolic: null == diastolic
          ? _value.diastolic
          : diastolic // ignore: cast_nullable_to_non_nullable
              as double,
      pulse_rate: null == pulse_rate
          ? _value.pulse_rate
          : pulse_rate // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date_time: null == date_time
          ? _value.date_time
          : date_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BloodPressureImplCopyWith<$Res>
    implements $BloodPressureCopyWith<$Res> {
  factory _$$BloodPressureImplCopyWith(
          _$BloodPressureImpl value, $Res Function(_$BloodPressureImpl) then) =
      __$$BloodPressureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double systolic,
      double diastolic,
      double pulse_rate,
      String? notes,
      DateTime date_time});
}

/// @nodoc
class __$$BloodPressureImplCopyWithImpl<$Res>
    extends _$BloodPressureCopyWithImpl<$Res, _$BloodPressureImpl>
    implements _$$BloodPressureImplCopyWith<$Res> {
  __$$BloodPressureImplCopyWithImpl(
      _$BloodPressureImpl _value, $Res Function(_$BloodPressureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systolic = null,
    Object? diastolic = null,
    Object? pulse_rate = null,
    Object? notes = freezed,
    Object? date_time = null,
  }) {
    return _then(_$BloodPressureImpl(
      systolic: null == systolic
          ? _value.systolic
          : systolic // ignore: cast_nullable_to_non_nullable
              as double,
      diastolic: null == diastolic
          ? _value.diastolic
          : diastolic // ignore: cast_nullable_to_non_nullable
              as double,
      pulse_rate: null == pulse_rate
          ? _value.pulse_rate
          : pulse_rate // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date_time: null == date_time
          ? _value.date_time
          : date_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BloodPressureImpl implements _BloodPressure {
  const _$BloodPressureImpl(
      {required this.systolic,
      required this.diastolic,
      required this.pulse_rate,
      this.notes,
      required this.date_time});

  factory _$BloodPressureImpl.fromJson(Map<String, dynamic> json) =>
      _$$BloodPressureImplFromJson(json);

  @override
  final double systolic;
  @override
  final double diastolic;
  @override
  final double pulse_rate;
  @override
  final String? notes;
  @override
  final DateTime date_time;

  @override
  String toString() {
    return 'BloodPressure(systolic: $systolic, diastolic: $diastolic, pulse_rate: $pulse_rate, notes: $notes, date_time: $date_time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodPressureImpl &&
            (identical(other.systolic, systolic) ||
                other.systolic == systolic) &&
            (identical(other.diastolic, diastolic) ||
                other.diastolic == diastolic) &&
            (identical(other.pulse_rate, pulse_rate) ||
                other.pulse_rate == pulse_rate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.date_time, date_time) ||
                other.date_time == date_time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, systolic, diastolic, pulse_rate, notes, date_time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodPressureImplCopyWith<_$BloodPressureImpl> get copyWith =>
      __$$BloodPressureImplCopyWithImpl<_$BloodPressureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BloodPressureImplToJson(
      this,
    );
  }
}

abstract class _BloodPressure implements BloodPressure {
  const factory _BloodPressure(
      {required final double systolic,
      required final double diastolic,
      required final double pulse_rate,
      final String? notes,
      required final DateTime date_time}) = _$BloodPressureImpl;

  factory _BloodPressure.fromJson(Map<String, dynamic> json) =
      _$BloodPressureImpl.fromJson;

  @override
  double get systolic;
  @override
  double get diastolic;
  @override
  double get pulse_rate;
  @override
  String? get notes;
  @override
  DateTime get date_time;
  @override
  @JsonKey(ignore: true)
  _$$BloodPressureImplCopyWith<_$BloodPressureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
