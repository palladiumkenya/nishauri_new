// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_regimen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTRegimen _$ARTRegimenFromJson(Map<String, dynamic> json) {
  return _ARTRegimen.fromJson(json);
}

/// @nodoc
mixin _$ARTRegimen {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTRegimenCopyWith<ARTRegimen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTRegimenCopyWith<$Res> {
  factory $ARTRegimenCopyWith(
          ARTRegimen value, $Res Function(ARTRegimen) then) =
      _$ARTRegimenCopyWithImpl<$Res, ARTRegimen>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      bool isCurrent,
      String createdAt});
}

/// @nodoc
class _$ARTRegimenCopyWithImpl<$Res, $Val extends ARTRegimen>
    implements $ARTRegimenCopyWith<$Res> {
  _$ARTRegimenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? isCurrent = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTRegimenImplCopyWith<$Res>
    implements $ARTRegimenCopyWith<$Res> {
  factory _$$ARTRegimenImplCopyWith(
          _$ARTRegimenImpl value, $Res Function(_$ARTRegimenImpl) then) =
      __$$ARTRegimenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      bool isCurrent,
      String createdAt});
}

/// @nodoc
class __$$ARTRegimenImplCopyWithImpl<$Res>
    extends _$ARTRegimenCopyWithImpl<$Res, _$ARTRegimenImpl>
    implements _$$ARTRegimenImplCopyWith<$Res> {
  __$$ARTRegimenImplCopyWithImpl(
      _$ARTRegimenImpl _value, $Res Function(_$ARTRegimenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? isCurrent = null,
    Object? createdAt = null,
  }) {
    return _then(_$ARTRegimenImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTRegimenImpl with DiagnosticableTreeMixin implements _ARTRegimen {
  const _$ARTRegimenImpl(
      {this.id,
      required this.name,
      this.description,
      this.isCurrent = false,
      required this.createdAt});

  factory _$ARTRegimenImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTRegimenImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isCurrent;
  @override
  final String createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTRegimen(id: $id, name: $name, description: $description, isCurrent: $isCurrent, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTRegimen'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('isCurrent', isCurrent))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTRegimenImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, isCurrent, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTRegimenImplCopyWith<_$ARTRegimenImpl> get copyWith =>
      __$$ARTRegimenImplCopyWithImpl<_$ARTRegimenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTRegimenImplToJson(
      this,
    );
  }
}

abstract class _ARTRegimen implements ARTRegimen {
  const factory _ARTRegimen(
      {final String? id,
      required final String name,
      final String? description,
      final bool isCurrent,
      required final String createdAt}) = _$ARTRegimenImpl;

  factory _ARTRegimen.fromJson(Map<String, dynamic> json) =
      _$ARTRegimenImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  bool get isCurrent;
  @override
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ARTRegimenImplCopyWith<_$ARTRegimenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
