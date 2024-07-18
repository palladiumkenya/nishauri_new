// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine_intake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MedicineIntake {
  /// Timestamp when the medicine was taken.
  DateTime get time => throw _privateConstructorUsedError;

  /// Description of the taken medicine.
  Medicine get medicine => throw _privateConstructorUsedError;

  /// Amount of medicine taken.
  ///
  /// When the medication has a default value, this must be set to that value,
  /// as it may change.
  Weight get dosis => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MedicineIntakeCopyWith<MedicineIntake> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicineIntakeCopyWith<$Res> {
  factory $MedicineIntakeCopyWith(
          MedicineIntake value, $Res Function(MedicineIntake) then) =
      _$MedicineIntakeCopyWithImpl<$Res, MedicineIntake>;
  @useResult
  $Res call({DateTime time, Medicine medicine, Weight dosis});

  $MedicineCopyWith<$Res> get medicine;
}

/// @nodoc
class _$MedicineIntakeCopyWithImpl<$Res, $Val extends MedicineIntake>
    implements $MedicineIntakeCopyWith<$Res> {
  _$MedicineIntakeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? medicine = null,
    Object? dosis = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      medicine: null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as Medicine,
      dosis: null == dosis
          ? _value.dosis
          : dosis // ignore: cast_nullable_to_non_nullable
              as Weight,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MedicineCopyWith<$Res> get medicine {
    return $MedicineCopyWith<$Res>(_value.medicine, (value) {
      return _then(_value.copyWith(medicine: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MedicineIntakeImplCopyWith<$Res>
    implements $MedicineIntakeCopyWith<$Res> {
  factory _$$MedicineIntakeImplCopyWith(_$MedicineIntakeImpl value,
          $Res Function(_$MedicineIntakeImpl) then) =
      __$$MedicineIntakeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, Medicine medicine, Weight dosis});

  @override
  $MedicineCopyWith<$Res> get medicine;
}

/// @nodoc
class __$$MedicineIntakeImplCopyWithImpl<$Res>
    extends _$MedicineIntakeCopyWithImpl<$Res, _$MedicineIntakeImpl>
    implements _$$MedicineIntakeImplCopyWith<$Res> {
  __$$MedicineIntakeImplCopyWithImpl(
      _$MedicineIntakeImpl _value, $Res Function(_$MedicineIntakeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? medicine = null,
    Object? dosis = null,
  }) {
    return _then(_$MedicineIntakeImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      medicine: null == medicine
          ? _value.medicine
          : medicine // ignore: cast_nullable_to_non_nullable
              as Medicine,
      dosis: null == dosis
          ? _value.dosis
          : dosis // ignore: cast_nullable_to_non_nullable
              as Weight,
    ));
  }
}

/// @nodoc

class _$MedicineIntakeImpl implements _MedicineIntake {
  const _$MedicineIntakeImpl(
      {required this.time, required this.medicine, required this.dosis});

  /// Timestamp when the medicine was taken.
  @override
  final DateTime time;

  /// Description of the taken medicine.
  @override
  final Medicine medicine;

  /// Amount of medicine taken.
  ///
  /// When the medication has a default value, this must be set to that value,
  /// as it may change.
  @override
  final Weight dosis;

  @override
  String toString() {
    return 'MedicineIntake(time: $time, medicine: $medicine, dosis: $dosis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineIntakeImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.medicine, medicine) ||
                other.medicine == medicine) &&
            (identical(other.dosis, dosis) || other.dosis == dosis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, medicine, dosis);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineIntakeImplCopyWith<_$MedicineIntakeImpl> get copyWith =>
      __$$MedicineIntakeImplCopyWithImpl<_$MedicineIntakeImpl>(
          this, _$identity);
}

abstract class _MedicineIntake implements MedicineIntake {
  const factory _MedicineIntake(
      {required final DateTime time,
      required final Medicine medicine,
      required final Weight dosis}) = _$MedicineIntakeImpl;

  @override

  /// Timestamp when the medicine was taken.
  DateTime get time;
  @override

  /// Description of the taken medicine.
  Medicine get medicine;
  @override

  /// Amount of medicine taken.
  ///
  /// When the medication has a default value, this must be set to that value,
  /// as it may change.
  Weight get dosis;
  @override
  @JsonKey(ignore: true)
  _$$MedicineIntakeImplCopyWith<_$MedicineIntakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
