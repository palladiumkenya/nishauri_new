// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blood_pressure_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BloodPressureRecord {
  /// Timestamp when the measurement was taken.
  DateTime get time => throw _privateConstructorUsedError;

  /// Systolic value of the measurement.
  Pressure? get sys => throw _privateConstructorUsedError;

  /// Diastolic value of the measurement.
  Pressure? get dia => throw _privateConstructorUsedError;

  /// Pulse value of the measurement in bpm.
  int? get pul => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BloodPressureRecordCopyWith<BloodPressureRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BloodPressureRecordCopyWith<$Res> {
  factory $BloodPressureRecordCopyWith(
          BloodPressureRecord value, $Res Function(BloodPressureRecord) then) =
      _$BloodPressureRecordCopyWithImpl<$Res, BloodPressureRecord>;
  @useResult
  $Res call({DateTime time, Pressure? sys, Pressure? dia, int? pul});
}

/// @nodoc
class _$BloodPressureRecordCopyWithImpl<$Res, $Val extends BloodPressureRecord>
    implements $BloodPressureRecordCopyWith<$Res> {
  _$BloodPressureRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? sys = freezed,
    Object? dia = freezed,
    Object? pul = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sys: freezed == sys
          ? _value.sys
          : sys // ignore: cast_nullable_to_non_nullable
              as Pressure?,
      dia: freezed == dia
          ? _value.dia
          : dia // ignore: cast_nullable_to_non_nullable
              as Pressure?,
      pul: freezed == pul
          ? _value.pul
          : pul // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BloodPressureRecordImplCopyWith<$Res>
    implements $BloodPressureRecordCopyWith<$Res> {
  factory _$$BloodPressureRecordImplCopyWith(_$BloodPressureRecordImpl value,
          $Res Function(_$BloodPressureRecordImpl) then) =
      __$$BloodPressureRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, Pressure? sys, Pressure? dia, int? pul});
}

/// @nodoc
class __$$BloodPressureRecordImplCopyWithImpl<$Res>
    extends _$BloodPressureRecordCopyWithImpl<$Res, _$BloodPressureRecordImpl>
    implements _$$BloodPressureRecordImplCopyWith<$Res> {
  __$$BloodPressureRecordImplCopyWithImpl(_$BloodPressureRecordImpl _value,
      $Res Function(_$BloodPressureRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? sys = freezed,
    Object? dia = freezed,
    Object? pul = freezed,
  }) {
    return _then(_$BloodPressureRecordImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sys: freezed == sys
          ? _value.sys
          : sys // ignore: cast_nullable_to_non_nullable
              as Pressure?,
      dia: freezed == dia
          ? _value.dia
          : dia // ignore: cast_nullable_to_non_nullable
              as Pressure?,
      pul: freezed == pul
          ? _value.pul
          : pul // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$BloodPressureRecordImpl implements _BloodPressureRecord {
  const _$BloodPressureRecordImpl(
      {required this.time, this.sys, this.dia, this.pul});

  /// Timestamp when the measurement was taken.
  @override
  final DateTime time;

  /// Systolic value of the measurement.
  @override
  final Pressure? sys;

  /// Diastolic value of the measurement.
  @override
  final Pressure? dia;

  /// Pulse value of the measurement in bpm.
  @override
  final int? pul;

  @override
  String toString() {
    return 'BloodPressureRecord(time: $time, sys: $sys, dia: $dia, pul: $pul)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodPressureRecordImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.sys, sys) || other.sys == sys) &&
            (identical(other.dia, dia) || other.dia == dia) &&
            (identical(other.pul, pul) || other.pul == pul));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, sys, dia, pul);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodPressureRecordImplCopyWith<_$BloodPressureRecordImpl> get copyWith =>
      __$$BloodPressureRecordImplCopyWithImpl<_$BloodPressureRecordImpl>(
          this, _$identity);
}

abstract class _BloodPressureRecord implements BloodPressureRecord {
  const factory _BloodPressureRecord(
      {required final DateTime time,
      final Pressure? sys,
      final Pressure? dia,
      final int? pul}) = _$BloodPressureRecordImpl;

  @override

  /// Timestamp when the measurement was taken.
  DateTime get time;
  @override

  /// Systolic value of the measurement.
  Pressure? get sys;
  @override

  /// Diastolic value of the measurement.
  Pressure? get dia;
  @override

  /// Pulse value of the measurement in bpm.
  int? get pul;
  @override
  @JsonKey(ignore: true)
  _$$BloodPressureRecordImplCopyWith<_$BloodPressureRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
