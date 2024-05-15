// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_receiver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CareReceiver _$CareReceiverFromJson(Map<String, dynamic> json) {
  return _CareReceiver.fromJson(json);
}

/// @nodoc
mixin _$CareReceiver {
  String get cccNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CareReceiverCopyWith<CareReceiver> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareReceiverCopyWith<$Res> {
  factory $CareReceiverCopyWith(
          CareReceiver value, $Res Function(CareReceiver) then) =
      _$CareReceiverCopyWithImpl<$Res, CareReceiver>;
  @useResult
  $Res call({String cccNumber, String name, String? phoneNumber});
}

/// @nodoc
class _$CareReceiverCopyWithImpl<$Res, $Val extends CareReceiver>
    implements $CareReceiverCopyWith<$Res> {
  _$CareReceiverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cccNumber = null,
    Object? name = null,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      cccNumber: null == cccNumber
          ? _value.cccNumber
          : cccNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CareReceiverImplCopyWith<$Res>
    implements $CareReceiverCopyWith<$Res> {
  factory _$$CareReceiverImplCopyWith(
          _$CareReceiverImpl value, $Res Function(_$CareReceiverImpl) then) =
      __$$CareReceiverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cccNumber, String name, String? phoneNumber});
}

/// @nodoc
class __$$CareReceiverImplCopyWithImpl<$Res>
    extends _$CareReceiverCopyWithImpl<$Res, _$CareReceiverImpl>
    implements _$$CareReceiverImplCopyWith<$Res> {
  __$$CareReceiverImplCopyWithImpl(
      _$CareReceiverImpl _value, $Res Function(_$CareReceiverImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cccNumber = null,
    Object? name = null,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$CareReceiverImpl(
      cccNumber: null == cccNumber
          ? _value.cccNumber
          : cccNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CareReceiverImpl implements _CareReceiver {
  const _$CareReceiverImpl(
      {required this.cccNumber, required this.name, this.phoneNumber});

  factory _$CareReceiverImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareReceiverImplFromJson(json);

  @override
  final String cccNumber;
  @override
  final String name;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'CareReceiver(cccNumber: $cccNumber, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareReceiverImpl &&
            (identical(other.cccNumber, cccNumber) ||
                other.cccNumber == cccNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cccNumber, name, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CareReceiverImplCopyWith<_$CareReceiverImpl> get copyWith =>
      __$$CareReceiverImplCopyWithImpl<_$CareReceiverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareReceiverImplToJson(
      this,
    );
  }
}

abstract class _CareReceiver implements CareReceiver {
  const factory _CareReceiver(
      {required final String cccNumber,
      required final String name,
      final String? phoneNumber}) = _$CareReceiverImpl;

  factory _CareReceiver.fromJson(Map<String, dynamic> json) =
      _$CareReceiverImpl.fromJson;

  @override
  String get cccNumber;
  @override
  String get name;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$CareReceiverImplCopyWith<_$CareReceiverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
