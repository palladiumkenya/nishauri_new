// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) {
  return _Diagnosis.fromJson(json);
}

/// @nodoc
mixin _$Diagnosis {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get dateRecorded => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiagnosisCopyWith<Diagnosis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisCopyWith<$Res> {
  factory $DiagnosisCopyWith(Diagnosis value, $Res Function(Diagnosis) then) =
      _$DiagnosisCopyWithImpl<$Res, Diagnosis>;
  @useResult
  $Res call({String uuid, String name, String dateRecorded, String value});
}

/// @nodoc
class _$DiagnosisCopyWithImpl<$Res, $Val extends Diagnosis>
    implements $DiagnosisCopyWith<$Res> {
  _$DiagnosisCopyWithImpl(this._value, this._then);

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
abstract class _$$DiagnosisImplCopyWith<$Res>
    implements $DiagnosisCopyWith<$Res> {
  factory _$$DiagnosisImplCopyWith(
          _$DiagnosisImpl value, $Res Function(_$DiagnosisImpl) then) =
      __$$DiagnosisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String name, String dateRecorded, String value});
}

/// @nodoc
class __$$DiagnosisImplCopyWithImpl<$Res>
    extends _$DiagnosisCopyWithImpl<$Res, _$DiagnosisImpl>
    implements _$$DiagnosisImplCopyWith<$Res> {
  __$$DiagnosisImplCopyWithImpl(
      _$DiagnosisImpl _value, $Res Function(_$DiagnosisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? dateRecorded = null,
    Object? value = null,
  }) {
    return _then(_$DiagnosisImpl(
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
class _$DiagnosisImpl with DiagnosticableTreeMixin implements _Diagnosis {
  const _$DiagnosisImpl(
      {required this.uuid,
      required this.name,
      required this.dateRecorded,
      required this.value});

  factory _$DiagnosisImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisImplFromJson(json);

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
    return 'Diagnosis(uuid: $uuid, name: $name, dateRecorded: $dateRecorded, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Diagnosis'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dateRecorded', dateRecorded))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisImpl &&
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
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      __$$DiagnosisImplCopyWithImpl<_$DiagnosisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisImplToJson(
      this,
    );
  }
}

abstract class _Diagnosis implements Diagnosis {
  const factory _Diagnosis(
      {required final String uuid,
      required final String name,
      required final String dateRecorded,
      required final String value}) = _$DiagnosisImpl;

  factory _Diagnosis.fromJson(Map<String, dynamic> json) =
      _$DiagnosisImpl.fromJson;

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
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
