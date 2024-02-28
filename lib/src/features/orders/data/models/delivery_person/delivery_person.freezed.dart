// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeliveryPerson _$DeliveryPersonFromJson(Map<String, dynamic> json) {
  return _DeliveryPerson.fromJson(json);
}

/// @nodoc
mixin _$DeliveryPerson {
  String get fullName => throw _privateConstructorUsedError;
  int get nationalId => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get pickupTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeliveryPersonCopyWith<DeliveryPerson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryPersonCopyWith<$Res> {
  factory $DeliveryPersonCopyWith(
          DeliveryPerson value, $Res Function(DeliveryPerson) then) =
      _$DeliveryPersonCopyWithImpl<$Res, DeliveryPerson>;
  @useResult
  $Res call(
      {String fullName, int nationalId, String phoneNumber, String pickupTime});
}

/// @nodoc
class _$DeliveryPersonCopyWithImpl<$Res, $Val extends DeliveryPerson>
    implements $DeliveryPersonCopyWith<$Res> {
  _$DeliveryPersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? nationalId = null,
    Object? phoneNumber = null,
    Object? pickupTime = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      nationalId: null == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryPersonImplCopyWith<$Res>
    implements $DeliveryPersonCopyWith<$Res> {
  factory _$$DeliveryPersonImplCopyWith(_$DeliveryPersonImpl value,
          $Res Function(_$DeliveryPersonImpl) then) =
      __$$DeliveryPersonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName, int nationalId, String phoneNumber, String pickupTime});
}

/// @nodoc
class __$$DeliveryPersonImplCopyWithImpl<$Res>
    extends _$DeliveryPersonCopyWithImpl<$Res, _$DeliveryPersonImpl>
    implements _$$DeliveryPersonImplCopyWith<$Res> {
  __$$DeliveryPersonImplCopyWithImpl(
      _$DeliveryPersonImpl _value, $Res Function(_$DeliveryPersonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? nationalId = null,
    Object? phoneNumber = null,
    Object? pickupTime = null,
  }) {
    return _then(_$DeliveryPersonImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      nationalId: null == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryPersonImpl
    with DiagnosticableTreeMixin
    implements _DeliveryPerson {
  const _$DeliveryPersonImpl(
      {required this.fullName,
      required this.nationalId,
      required this.phoneNumber,
      required this.pickupTime});

  factory _$DeliveryPersonImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryPersonImplFromJson(json);

  @override
  final String fullName;
  @override
  final int nationalId;
  @override
  final String phoneNumber;
  @override
  final String pickupTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeliveryPerson(fullName: $fullName, nationalId: $nationalId, phoneNumber: $phoneNumber, pickupTime: $pickupTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeliveryPerson'))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('nationalId', nationalId))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('pickupTime', pickupTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryPersonImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, nationalId, phoneNumber, pickupTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryPersonImplCopyWith<_$DeliveryPersonImpl> get copyWith =>
      __$$DeliveryPersonImplCopyWithImpl<_$DeliveryPersonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryPersonImplToJson(
      this,
    );
  }
}

abstract class _DeliveryPerson implements DeliveryPerson {
  const factory _DeliveryPerson(
      {required final String fullName,
      required final int nationalId,
      required final String phoneNumber,
      required final String pickupTime}) = _$DeliveryPersonImpl;

  factory _DeliveryPerson.fromJson(Map<String, dynamic> json) =
      _$DeliveryPersonImpl.fromJson;

  @override
  String get fullName;
  @override
  int get nationalId;
  @override
  String get phoneNumber;
  @override
  String get pickupTime;
  @override
  @JsonKey(ignore: true)
  _$$DeliveryPersonImplCopyWith<_$DeliveryPersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
