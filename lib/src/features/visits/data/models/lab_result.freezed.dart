// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lab_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LabResult _$LabResultFromJson(Map<String, dynamic> json) {
  return _LabResult.fromJson(json);
}

/// @nodoc
mixin _$LabResult {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get dateRecorded => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LabResultCopyWith<LabResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabResultCopyWith<$Res> {
  factory $LabResultCopyWith(LabResult value, $Res Function(LabResult) then) =
      _$LabResultCopyWithImpl<$Res, LabResult>;
  @useResult
  $Res call({String uuid, String name, String dateRecorded, String value});
}

/// @nodoc
class _$LabResultCopyWithImpl<$Res, $Val extends LabResult>
    implements $LabResultCopyWith<$Res> {
  _$LabResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? dateRecorded = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LabResultImplCopyWith<$Res>
    implements $LabResultCopyWith<$Res> {
  factory _$$LabResultImplCopyWith(
          _$LabResultImpl value, $Res Function(_$LabResultImpl) then) =
      __$$LabResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String name, String dateRecorded, String value});
}

/// @nodoc
class __$$LabResultImplCopyWithImpl<$Res>
    extends _$LabResultCopyWithImpl<$Res, _$LabResultImpl>
    implements _$$LabResultImplCopyWith<$Res> {
  __$$LabResultImplCopyWithImpl(
      _$LabResultImpl _value, $Res Function(_$LabResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? dateRecorded = null,
    Object? value = null,
  }) {
    return _then(_$LabResultImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LabResultImpl with DiagnosticableTreeMixin implements _LabResult {
  const _$LabResultImpl(
      {required this.uuid,
      required this.name,
      required this.dateRecorded,
      required this.value});

  factory _$LabResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabResultImplFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final String dateRecorded;
  @override
  final String value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LabResult(uuid: $uuid, name: $name, dateRecorded: $dateRecorded, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LabResult'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dateRecorded', dateRecorded))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabResultImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateRecorded, dateRecorded) ||
                other.dateRecorded == dateRecorded) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, dateRecorded, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LabResultImplCopyWith<_$LabResultImpl> get copyWith =>
      __$$LabResultImplCopyWithImpl<_$LabResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LabResultImplToJson(
      this,
    );
  }
}

abstract class _LabResult implements LabResult {
  const factory _LabResult(
      {required final String uuid,
      required final String name,
      required final String dateRecorded,
      required final String value}) = _$LabResultImpl;

  factory _LabResult.fromJson(Map<String, dynamic> json) =
      _$LabResultImpl.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  String get dateRecorded;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$LabResultImplCopyWith<_$LabResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
