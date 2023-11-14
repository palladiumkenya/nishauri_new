// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTGroupSubscription _$ARTGroupSubscriptionFromJson(Map<String, dynamic> json) {
  return _ARTGroupSubscription.fromJson(json);
}

/// @nodoc
mixin _$ARTGroupSubscription {
  String? get id => throw _privateConstructorUsedError;
  String get group => throw _privateConstructorUsedError;
  String get patient => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool? get isCurrent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupSubscriptionCopyWith<ARTGroupSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupSubscriptionCopyWith<$Res> {
  factory $ARTGroupSubscriptionCopyWith(ARTGroupSubscription value,
          $Res Function(ARTGroupSubscription) then) =
      _$ARTGroupSubscriptionCopyWithImpl<$Res, ARTGroupSubscription>;
  @useResult
  $Res call(
      {String? id,
      String group,
      String patient,
      String? name,
      bool? isCurrent});
}

/// @nodoc
class _$ARTGroupSubscriptionCopyWithImpl<$Res,
        $Val extends ARTGroupSubscription>
    implements $ARTGroupSubscriptionCopyWith<$Res> {
  _$ARTGroupSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? group = null,
    Object? patient = null,
    Object? name = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      patient: null == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTGroupSubscriptionImplCopyWith<$Res>
    implements $ARTGroupSubscriptionCopyWith<$Res> {
  factory _$$ARTGroupSubscriptionImplCopyWith(_$ARTGroupSubscriptionImpl value,
          $Res Function(_$ARTGroupSubscriptionImpl) then) =
      __$$ARTGroupSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String group,
      String patient,
      String? name,
      bool? isCurrent});
}

/// @nodoc
class __$$ARTGroupSubscriptionImplCopyWithImpl<$Res>
    extends _$ARTGroupSubscriptionCopyWithImpl<$Res, _$ARTGroupSubscriptionImpl>
    implements _$$ARTGroupSubscriptionImplCopyWith<$Res> {
  __$$ARTGroupSubscriptionImplCopyWithImpl(_$ARTGroupSubscriptionImpl _value,
      $Res Function(_$ARTGroupSubscriptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? group = null,
    Object? patient = null,
    Object? name = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_$ARTGroupSubscriptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      patient: null == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupSubscriptionImpl
    with DiagnosticableTreeMixin
    implements _ARTGroupSubscription {
  const _$ARTGroupSubscriptionImpl(
      {this.id,
      required this.group,
      required this.patient,
      this.name,
      this.isCurrent = false});

  factory _$ARTGroupSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupSubscriptionImplFromJson(json);

  @override
  final String? id;
  @override
  final String group;
  @override
  final String patient;
  @override
  final String? name;
  @override
  @JsonKey()
  final bool? isCurrent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroupSubscription(id: $id, group: $group, patient: $patient, name: $name, isCurrent: $isCurrent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroupSubscription'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('patient', patient))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isCurrent', isCurrent));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupSubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, group, patient, name, isCurrent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupSubscriptionImplCopyWith<_$ARTGroupSubscriptionImpl>
      get copyWith =>
          __$$ARTGroupSubscriptionImplCopyWithImpl<_$ARTGroupSubscriptionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupSubscriptionImplToJson(
      this,
    );
  }
}

abstract class _ARTGroupSubscription implements ARTGroupSubscription {
  const factory _ARTGroupSubscription(
      {final String? id,
      required final String group,
      required final String patient,
      final String? name,
      final bool? isCurrent}) = _$ARTGroupSubscriptionImpl;

  factory _ARTGroupSubscription.fromJson(Map<String, dynamic> json) =
      _$ARTGroupSubscriptionImpl.fromJson;

  @override
  String? get id;
  @override
  String get group;
  @override
  String get patient;
  @override
  String? get name;
  @override
  bool? get isCurrent;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupSubscriptionImplCopyWith<_$ARTGroupSubscriptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
