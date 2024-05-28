// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConfirmDelivery _$ConfirmDeliveryFromJson(Map<String, dynamic> json) {
  return _ConfirmDelivery.fromJson(json);
}

/// @nodoc
mixin _$ConfirmDelivery {
  String? get id => throw _privateConstructorUsedError;
  int? get order_id => throw _privateConstructorUsedError;
  String get confirmation_code => throw _privateConstructorUsedError;
  int get is_received => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfirmDeliveryCopyWith<ConfirmDelivery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmDeliveryCopyWith<$Res> {
  factory $ConfirmDeliveryCopyWith(
          ConfirmDelivery value, $Res Function(ConfirmDelivery) then) =
      _$ConfirmDeliveryCopyWithImpl<$Res, ConfirmDelivery>;
  @useResult
  $Res call(
      {String? id,
      int? order_id,
      String confirmation_code,
      int is_received,
      String? comment});
}

/// @nodoc
class _$ConfirmDeliveryCopyWithImpl<$Res, $Val extends ConfirmDelivery>
    implements $ConfirmDeliveryCopyWith<$Res> {
  _$ConfirmDeliveryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? order_id = freezed,
    Object? confirmation_code = null,
    Object? is_received = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      confirmation_code: null == confirmation_code
          ? _value.confirmation_code
          : confirmation_code // ignore: cast_nullable_to_non_nullable
              as String,
      is_received: null == is_received
          ? _value.is_received
          : is_received // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfirmDeliveryImplCopyWith<$Res>
    implements $ConfirmDeliveryCopyWith<$Res> {
  factory _$$ConfirmDeliveryImplCopyWith(_$ConfirmDeliveryImpl value,
          $Res Function(_$ConfirmDeliveryImpl) then) =
      __$$ConfirmDeliveryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? order_id,
      String confirmation_code,
      int is_received,
      String? comment});
}

/// @nodoc
class __$$ConfirmDeliveryImplCopyWithImpl<$Res>
    extends _$ConfirmDeliveryCopyWithImpl<$Res, _$ConfirmDeliveryImpl>
    implements _$$ConfirmDeliveryImplCopyWith<$Res> {
  __$$ConfirmDeliveryImplCopyWithImpl(
      _$ConfirmDeliveryImpl _value, $Res Function(_$ConfirmDeliveryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? order_id = freezed,
    Object? confirmation_code = null,
    Object? is_received = null,
    Object? comment = freezed,
  }) {
    return _then(_$ConfirmDeliveryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      confirmation_code: null == confirmation_code
          ? _value.confirmation_code
          : confirmation_code // ignore: cast_nullable_to_non_nullable
              as String,
      is_received: null == is_received
          ? _value.is_received
          : is_received // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfirmDeliveryImpl implements _ConfirmDelivery {
  const _$ConfirmDeliveryImpl(
      {this.id,
      this.order_id,
      required this.confirmation_code,
      required this.is_received,
      this.comment});

  factory _$ConfirmDeliveryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfirmDeliveryImplFromJson(json);

  @override
  final String? id;
  @override
  final int? order_id;
  @override
  final String confirmation_code;
  @override
  final int is_received;
  @override
  final String? comment;

  @override
  String toString() {
    return 'ConfirmDelivery(id: $id, order_id: $order_id, confirmation_code: $confirmation_code, is_received: $is_received, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmDeliveryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order_id, order_id) ||
                other.order_id == order_id) &&
            (identical(other.confirmation_code, confirmation_code) ||
                other.confirmation_code == confirmation_code) &&
            (identical(other.is_received, is_received) ||
                other.is_received == is_received) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order_id, confirmation_code, is_received, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmDeliveryImplCopyWith<_$ConfirmDeliveryImpl> get copyWith =>
      __$$ConfirmDeliveryImplCopyWithImpl<_$ConfirmDeliveryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfirmDeliveryImplToJson(
      this,
    );
  }
}

abstract class _ConfirmDelivery implements ConfirmDelivery {
  const factory _ConfirmDelivery(
      {final String? id,
      final int? order_id,
      required final String confirmation_code,
      required final int is_received,
      final String? comment}) = _$ConfirmDeliveryImpl;

  factory _ConfirmDelivery.fromJson(Map<String, dynamic> json) =
      _$ConfirmDeliveryImpl.fromJson;

  @override
  String? get id;
  @override
  int? get order_id;
  @override
  String get confirmation_code;
  @override
  int get is_received;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$ConfirmDeliveryImplCopyWith<_$ConfirmDeliveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
