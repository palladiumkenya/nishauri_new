// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blood_sugar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BloodSugar _$BloodSugarFromJson(Map<String, dynamic> json) {
  return _BloodSugar.fromJson(json);
}

/// @nodoc
mixin _$BloodSugar {
  double get level => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BloodSugarCopyWith<BloodSugar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BloodSugarCopyWith<$Res> {
  factory $BloodSugarCopyWith(
          BloodSugar value, $Res Function(BloodSugar) then) =
      _$BloodSugarCopyWithImpl<$Res, BloodSugar>;
  @useResult
  $Res call(
      {double level, DateTime created_at, String condition, String? notes});
}

/// @nodoc
class _$BloodSugarCopyWithImpl<$Res, $Val extends BloodSugar>
    implements $BloodSugarCopyWith<$Res> {
  _$BloodSugarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? created_at = null,
    Object? condition = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BloodSugarImplCopyWith<$Res>
    implements $BloodSugarCopyWith<$Res> {
  factory _$$BloodSugarImplCopyWith(
          _$BloodSugarImpl value, $Res Function(_$BloodSugarImpl) then) =
      __$$BloodSugarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double level, DateTime created_at, String condition, String? notes});
}

/// @nodoc
class __$$BloodSugarImplCopyWithImpl<$Res>
    extends _$BloodSugarCopyWithImpl<$Res, _$BloodSugarImpl>
    implements _$$BloodSugarImplCopyWith<$Res> {
  __$$BloodSugarImplCopyWithImpl(
      _$BloodSugarImpl _value, $Res Function(_$BloodSugarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? created_at = null,
    Object? condition = null,
    Object? notes = freezed,
  }) {
    return _then(_$BloodSugarImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BloodSugarImpl implements _BloodSugar {
  const _$BloodSugarImpl(
      {required this.level,
      required this.created_at,
      required this.condition,
      this.notes});

  factory _$BloodSugarImpl.fromJson(Map<String, dynamic> json) =>
      _$$BloodSugarImplFromJson(json);

  @override
  final double level;
  @override
  final DateTime created_at;
  @override
  final String condition;
  @override
  final String? notes;

  @override
  String toString() {
    return 'BloodSugar(level: $level, created_at: $created_at, condition: $condition, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodSugarImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, level, created_at, condition, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodSugarImplCopyWith<_$BloodSugarImpl> get copyWith =>
      __$$BloodSugarImplCopyWithImpl<_$BloodSugarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BloodSugarImplToJson(
      this,
    );
  }
}

abstract class _BloodSugar implements BloodSugar {
  const factory _BloodSugar(
      {required final double level,
      required final DateTime created_at,
      required final String condition,
      final String? notes}) = _$BloodSugarImpl;

  factory _BloodSugar.fromJson(Map<String, dynamic> json) =
      _$BloodSugarImpl.fromJson;

  @override
  double get level;
  @override
  DateTime get created_at;
  @override
  String get condition;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$BloodSugarImplCopyWith<_$BloodSugarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
