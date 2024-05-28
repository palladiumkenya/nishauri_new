// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bmi_nutrition_maping.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BMIStatusNutrition _$BMIStatusNutritionFromJson(Map<String, dynamic> json) {
  return _BMIStatusNutrition.fromJson(json);
}

/// @nodoc
mixin _$BMIStatusNutrition {
  String? get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BMIStatusNutritionCopyWith<BMIStatusNutrition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BMIStatusNutritionCopyWith<$Res> {
  factory $BMIStatusNutritionCopyWith(
          BMIStatusNutrition value, $Res Function(BMIStatusNutrition) then) =
      _$BMIStatusNutritionCopyWithImpl<$Res, BMIStatusNutrition>;
  @useResult
  $Res call(
      {String? id,
      String status,
      String description,
      String createdAt,
      bool isActive,
      String updatedAt,
      String? deletedAt});
}

/// @nodoc
class _$BMIStatusNutritionCopyWithImpl<$Res, $Val extends BMIStatusNutrition>
    implements $BMIStatusNutritionCopyWith<$Res> {
  _$BMIStatusNutritionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = null,
    Object? description = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BMIStatusNutritionImplCopyWith<$Res>
    implements $BMIStatusNutritionCopyWith<$Res> {
  factory _$$BMIStatusNutritionImplCopyWith(_$BMIStatusNutritionImpl value,
          $Res Function(_$BMIStatusNutritionImpl) then) =
      __$$BMIStatusNutritionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String status,
      String description,
      String createdAt,
      bool isActive,
      String updatedAt,
      String? deletedAt});
}

/// @nodoc
class __$$BMIStatusNutritionImplCopyWithImpl<$Res>
    extends _$BMIStatusNutritionCopyWithImpl<$Res, _$BMIStatusNutritionImpl>
    implements _$$BMIStatusNutritionImplCopyWith<$Res> {
  __$$BMIStatusNutritionImplCopyWithImpl(_$BMIStatusNutritionImpl _value,
      $Res Function(_$BMIStatusNutritionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = null,
    Object? description = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$BMIStatusNutritionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BMIStatusNutritionImpl
    with DiagnosticableTreeMixin
    implements _BMIStatusNutrition {
  const _$BMIStatusNutritionImpl(
      {this.id,
      required this.status,
      required this.description,
      required this.createdAt,
      required this.isActive,
      required this.updatedAt,
      this.deletedAt});

  factory _$BMIStatusNutritionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BMIStatusNutritionImplFromJson(json);

  @override
  final String? id;
  @override
  final String status;
  @override
  final String description;
  @override
  final String createdAt;
  @override
  final bool isActive;
  @override
  final String updatedAt;
  @override
  final String? deletedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BMIStatusNutrition(id: $id, status: $status, description: $description, createdAt: $createdAt, isActive: $isActive, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BMIStatusNutrition'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('deletedAt', deletedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BMIStatusNutritionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, description,
      createdAt, isActive, updatedAt, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BMIStatusNutritionImplCopyWith<_$BMIStatusNutritionImpl> get copyWith =>
      __$$BMIStatusNutritionImplCopyWithImpl<_$BMIStatusNutritionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BMIStatusNutritionImplToJson(
      this,
    );
  }
}

abstract class _BMIStatusNutrition implements BMIStatusNutrition {
  const factory _BMIStatusNutrition(
      {final String? id,
      required final String status,
      required final String description,
      required final String createdAt,
      required final bool isActive,
      required final String updatedAt,
      final String? deletedAt}) = _$BMIStatusNutritionImpl;

  factory _BMIStatusNutrition.fromJson(Map<String, dynamic> json) =
      _$BMIStatusNutritionImpl.fromJson;

  @override
  String? get id;
  @override
  String get status;
  @override
  String get description;
  @override
  String get createdAt;
  @override
  bool get isActive;
  @override
  String get updatedAt;
  @override
  String? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$BMIStatusNutritionImplCopyWith<_$BMIStatusNutritionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
