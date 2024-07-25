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
  int get id => throw _privateConstructorUsedError;
  double get level => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

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
  $Res call({int id, double level, DateTime timestamp});
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
    Object? id = null,
    Object? level = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
  $Res call({int id, double level, DateTime timestamp});
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
    Object? id = null,
    Object? level = null,
    Object? timestamp = null,
  }) {
    return _then(_$BloodSugarImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BloodSugarImpl implements _BloodSugar {
  const _$BloodSugarImpl(
      {required this.id, required this.level, required this.timestamp});

  factory _$BloodSugarImpl.fromJson(Map<String, dynamic> json) =>
      _$$BloodSugarImplFromJson(json);

  @override
  final int id;
  @override
  final double level;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'BloodSugar(id: $id, level: $level, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodSugarImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, level, timestamp);

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
      {required final int id,
      required final double level,
      required final DateTime timestamp}) = _$BloodSugarImpl;

  factory _BloodSugar.fromJson(Map<String, dynamic> json) =
      _$BloodSugarImpl.fromJson;

  @override
  int get id;
  @override
  double get level;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$BloodSugarImplCopyWith<_$BloodSugarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
