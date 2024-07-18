// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Medicine {
  /// Name of the medicine.
  String get designation => throw _privateConstructorUsedError;

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  int? get color => throw _privateConstructorUsedError;

  /// Default dosis of medication.
  Weight? get dosis => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MedicineCopyWith<Medicine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicineCopyWith<$Res> {
  factory $MedicineCopyWith(Medicine value, $Res Function(Medicine) then) =
      _$MedicineCopyWithImpl<$Res, Medicine>;
  @useResult
  $Res call({String designation, int? color, Weight? dosis});
}

/// @nodoc
class _$MedicineCopyWithImpl<$Res, $Val extends Medicine>
    implements $MedicineCopyWith<$Res> {
  _$MedicineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designation = null,
    Object? color = freezed,
    Object? dosis = freezed,
  }) {
    return _then(_value.copyWith(
      designation: null == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      dosis: freezed == dosis
          ? _value.dosis
          : dosis // ignore: cast_nullable_to_non_nullable
              as Weight?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicineImplCopyWith<$Res>
    implements $MedicineCopyWith<$Res> {
  factory _$$MedicineImplCopyWith(
          _$MedicineImpl value, $Res Function(_$MedicineImpl) then) =
      __$$MedicineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String designation, int? color, Weight? dosis});
}

/// @nodoc
class __$$MedicineImplCopyWithImpl<$Res>
    extends _$MedicineCopyWithImpl<$Res, _$MedicineImpl>
    implements _$$MedicineImplCopyWith<$Res> {
  __$$MedicineImplCopyWithImpl(
      _$MedicineImpl _value, $Res Function(_$MedicineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designation = null,
    Object? color = freezed,
    Object? dosis = freezed,
  }) {
    return _then(_$MedicineImpl(
      designation: null == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      dosis: freezed == dosis
          ? _value.dosis
          : dosis // ignore: cast_nullable_to_non_nullable
              as Weight?,
    ));
  }
}

/// @nodoc

class _$MedicineImpl implements _Medicine {
  const _$MedicineImpl({required this.designation, this.color, this.dosis});

  /// Name of the medicine.
  @override
  final String designation;

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  @override
  final int? color;

  /// Default dosis of medication.
  @override
  final Weight? dosis;

  @override
  String toString() {
    return 'Medicine(designation: $designation, color: $color, dosis: $dosis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineImpl &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dosis, dosis) || other.dosis == dosis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, designation, color, dosis);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineImplCopyWith<_$MedicineImpl> get copyWith =>
      __$$MedicineImplCopyWithImpl<_$MedicineImpl>(this, _$identity);
}

abstract class _Medicine implements Medicine {
  const factory _Medicine(
      {required final String designation,
      final int? color,
      final Weight? dosis}) = _$MedicineImpl;

  @override

  /// Name of the medicine.
  String get designation;
  @override

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  int? get color;
  @override

  /// Default dosis of medication.
  Weight? get dosis;
  @override
  @JsonKey(ignore: true)
  _$$MedicineImplCopyWith<_$MedicineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
