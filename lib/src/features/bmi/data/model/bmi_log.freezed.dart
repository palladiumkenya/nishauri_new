// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bmi_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BMILog _$BMILogFromJson(Map<String, dynamic> json) {
  return _BMILog.fromJson(json);
}

/// @nodoc
mixin _$BMILog {
  double get weight => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get bmi => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BMILogCopyWith<BMILog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BMILogCopyWith<$Res> {
  factory $BMILogCopyWith(BMILog value, $Res Function(BMILog) then) =
      _$BMILogCopyWithImpl<$Res, BMILog>;
  @useResult
  $Res call({double weight, double height, double bmi});
}

/// @nodoc
class _$BMILogCopyWithImpl<$Res, $Val extends BMILog>
    implements $BMILogCopyWith<$Res> {
  _$BMILogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? height = null,
    Object? bmi = null,
  }) {
    return _then(_value.copyWith(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BMILogImplCopyWith<$Res> implements $BMILogCopyWith<$Res> {
  factory _$$BMILogImplCopyWith(
          _$BMILogImpl value, $Res Function(_$BMILogImpl) then) =
      __$$BMILogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double weight, double height, double bmi});
}

/// @nodoc
class __$$BMILogImplCopyWithImpl<$Res>
    extends _$BMILogCopyWithImpl<$Res, _$BMILogImpl>
    implements _$$BMILogImplCopyWith<$Res> {
  __$$BMILogImplCopyWithImpl(
      _$BMILogImpl _value, $Res Function(_$BMILogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? height = null,
    Object? bmi = null,
  }) {
    return _then(_$BMILogImpl(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BMILogImpl implements _BMILog {
  const _$BMILogImpl(
      {required this.weight, required this.height, required this.bmi});

  factory _$BMILogImpl.fromJson(Map<String, dynamic> json) =>
      _$$BMILogImplFromJson(json);

  @override
  final double weight;
  @override
  final double height;
  @override
  final double bmi;

  @override
  String toString() {
    return 'BMILog(weight: $weight, height: $height, bmi: $bmi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BMILogImpl &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.bmi, bmi) || other.bmi == bmi));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, weight, height, bmi);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BMILogImplCopyWith<_$BMILogImpl> get copyWith =>
      __$$BMILogImplCopyWithImpl<_$BMILogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BMILogImplToJson(
      this,
    );
  }
}

abstract class _BMILog implements BMILog {
  const factory _BMILog(
      {required final double weight,
      required final double height,
      required final double bmi}) = _$BMILogImpl;

  factory _BMILog.fromJson(Map<String, dynamic> json) = _$BMILogImpl.fromJson;

  @override
  double get weight;
  @override
  double get height;
  @override
  double get bmi;
  @override
  @JsonKey(ignore: true)
  _$$BMILogImplCopyWith<_$BMILogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
