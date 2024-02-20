// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_treatment_support.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTTreatmentSupport _$ARTTreatmentSupportFromJson(Map<String, dynamic> json) {
  return _ARTTreatmentSupport.fromJson(json);
}

/// @nodoc
mixin _$ARTTreatmentSupport {
  String? get id => throw _privateConstructorUsedError;
  CareReceiver get careReceiver => throw _privateConstructorUsedError;
  CareGiver get careGiver => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTTreatmentSupportCopyWith<ARTTreatmentSupport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTTreatmentSupportCopyWith<$Res> {
  factory $ARTTreatmentSupportCopyWith(
          ARTTreatmentSupport value, $Res Function(ARTTreatmentSupport) then) =
      _$ARTTreatmentSupportCopyWithImpl<$Res, ARTTreatmentSupport>;
  @useResult
  $Res call({String? id, CareReceiver careReceiver, CareGiver careGiver});

  $CareReceiverCopyWith<$Res> get careReceiver;
  $CareGiverCopyWith<$Res> get careGiver;
}

/// @nodoc
class _$ARTTreatmentSupportCopyWithImpl<$Res, $Val extends ARTTreatmentSupport>
    implements $ARTTreatmentSupportCopyWith<$Res> {
  _$ARTTreatmentSupportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? careReceiver = null,
    Object? careGiver = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      careReceiver: null == careReceiver
          ? _value.careReceiver
          : careReceiver // ignore: cast_nullable_to_non_nullable
              as CareReceiver,
      careGiver: null == careGiver
          ? _value.careGiver
          : careGiver // ignore: cast_nullable_to_non_nullable
              as CareGiver,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CareReceiverCopyWith<$Res> get careReceiver {
    return $CareReceiverCopyWith<$Res>(_value.careReceiver, (value) {
      return _then(_value.copyWith(careReceiver: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CareGiverCopyWith<$Res> get careGiver {
    return $CareGiverCopyWith<$Res>(_value.careGiver, (value) {
      return _then(_value.copyWith(careGiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ARTTreatmentSupportImplCopyWith<$Res>
    implements $ARTTreatmentSupportCopyWith<$Res> {
  factory _$$ARTTreatmentSupportImplCopyWith(_$ARTTreatmentSupportImpl value,
          $Res Function(_$ARTTreatmentSupportImpl) then) =
      __$$ARTTreatmentSupportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, CareReceiver careReceiver, CareGiver careGiver});

  @override
  $CareReceiverCopyWith<$Res> get careReceiver;
  @override
  $CareGiverCopyWith<$Res> get careGiver;
}

/// @nodoc
class __$$ARTTreatmentSupportImplCopyWithImpl<$Res>
    extends _$ARTTreatmentSupportCopyWithImpl<$Res, _$ARTTreatmentSupportImpl>
    implements _$$ARTTreatmentSupportImplCopyWith<$Res> {
  __$$ARTTreatmentSupportImplCopyWithImpl(_$ARTTreatmentSupportImpl _value,
      $Res Function(_$ARTTreatmentSupportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? careReceiver = null,
    Object? careGiver = null,
  }) {
    return _then(_$ARTTreatmentSupportImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      careReceiver: null == careReceiver
          ? _value.careReceiver
          : careReceiver // ignore: cast_nullable_to_non_nullable
              as CareReceiver,
      careGiver: null == careGiver
          ? _value.careGiver
          : careGiver // ignore: cast_nullable_to_non_nullable
              as CareGiver,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTTreatmentSupportImpl
    with DiagnosticableTreeMixin
    implements _ARTTreatmentSupport {
  const _$ARTTreatmentSupportImpl(
      {this.id, required this.careReceiver, required this.careGiver});

  factory _$ARTTreatmentSupportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTTreatmentSupportImplFromJson(json);

  @override
  final String? id;
  @override
  final CareReceiver careReceiver;
  @override
  final CareGiver careGiver;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTTreatmentSupport(id: $id, careReceiver: $careReceiver, careGiver: $careGiver)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTTreatmentSupport'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('careReceiver', careReceiver))
      ..add(DiagnosticsProperty('careGiver', careGiver));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTTreatmentSupportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careReceiver, careReceiver) ||
                other.careReceiver == careReceiver) &&
            (identical(other.careGiver, careGiver) ||
                other.careGiver == careGiver));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, careReceiver, careGiver);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTTreatmentSupportImplCopyWith<_$ARTTreatmentSupportImpl> get copyWith =>
      __$$ARTTreatmentSupportImplCopyWithImpl<_$ARTTreatmentSupportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTTreatmentSupportImplToJson(
      this,
    );
  }
}

abstract class _ARTTreatmentSupport implements ARTTreatmentSupport {
  const factory _ARTTreatmentSupport(
      {final String? id,
      required final CareReceiver careReceiver,
      required final CareGiver careGiver}) = _$ARTTreatmentSupportImpl;

  factory _ARTTreatmentSupport.fromJson(Map<String, dynamic> json) =
      _$ARTTreatmentSupportImpl.fromJson;

  @override
  String? get id;
  @override
  CareReceiver get careReceiver;
  @override
  CareGiver get careGiver;
  @override
  @JsonKey(ignore: true)
  _$$ARTTreatmentSupportImplCopyWith<_$ARTTreatmentSupportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
