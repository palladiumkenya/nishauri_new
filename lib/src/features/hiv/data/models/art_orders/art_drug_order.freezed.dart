// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_drug_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTDrugOrder _$ARTDrugOrderFromJson(Map<String, dynamic> json) {
  return _ARTDrugOrder.fromJson(json);
}

/// @nodoc
mixin _$ARTDrugOrder {
  String? get id => throw _privateConstructorUsedError;
  ARTEvent? get event => throw _privateConstructorUsedError;
  ARTAppointment? get appointment => throw _privateConstructorUsedError;
  Address get deliveryAddress => throw _privateConstructorUsedError;
  String get deliveryMethod => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  Courier? get courierService => throw _privateConstructorUsedError;
  DeliveryPerson? get deliveryPerson => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTDrugOrderCopyWith<ARTDrugOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTDrugOrderCopyWith<$Res> {
  factory $ARTDrugOrderCopyWith(
          ARTDrugOrder value, $Res Function(ARTDrugOrder) then) =
      _$ARTDrugOrderCopyWithImpl<$Res, ARTDrugOrder>;
  @useResult
  $Res call(
      {String? id,
      ARTEvent? event,
      ARTAppointment? appointment,
      Address deliveryAddress,
      String deliveryMethod,
      String phoneNumber,
      String? type,
      Courier? courierService,
      DeliveryPerson? deliveryPerson,
      String? createdAt,
      String? updateAt});

  $ARTEventCopyWith<$Res>? get event;
  $ARTAppointmentCopyWith<$Res>? get appointment;
  $AddressCopyWith<$Res> get deliveryAddress;
  $CourierCopyWith<$Res>? get courierService;
  $DeliveryPersonCopyWith<$Res>? get deliveryPerson;
}

/// @nodoc
class _$ARTDrugOrderCopyWithImpl<$Res, $Val extends ARTDrugOrder>
    implements $ARTDrugOrderCopyWith<$Res> {
  _$ARTDrugOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? event = freezed,
    Object? appointment = freezed,
    Object? deliveryAddress = null,
    Object? deliveryMethod = null,
    Object? phoneNumber = null,
    Object? type = freezed,
    Object? courierService = freezed,
    Object? deliveryPerson = freezed,
    Object? createdAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ARTEvent?,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as ARTAppointment?,
      deliveryAddress: null == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      deliveryMethod: null == deliveryMethod
          ? _value.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      courierService: freezed == courierService
          ? _value.courierService
          : courierService // ignore: cast_nullable_to_non_nullable
              as Courier?,
      deliveryPerson: freezed == deliveryPerson
          ? _value.deliveryPerson
          : deliveryPerson // ignore: cast_nullable_to_non_nullable
              as DeliveryPerson?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ARTEventCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $ARTEventCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ARTAppointmentCopyWith<$Res>? get appointment {
    if (_value.appointment == null) {
      return null;
    }

    return $ARTAppointmentCopyWith<$Res>(_value.appointment!, (value) {
      return _then(_value.copyWith(appointment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get deliveryAddress {
    return $AddressCopyWith<$Res>(_value.deliveryAddress, (value) {
      return _then(_value.copyWith(deliveryAddress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CourierCopyWith<$Res>? get courierService {
    if (_value.courierService == null) {
      return null;
    }

    return $CourierCopyWith<$Res>(_value.courierService!, (value) {
      return _then(_value.copyWith(courierService: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeliveryPersonCopyWith<$Res>? get deliveryPerson {
    if (_value.deliveryPerson == null) {
      return null;
    }

    return $DeliveryPersonCopyWith<$Res>(_value.deliveryPerson!, (value) {
      return _then(_value.copyWith(deliveryPerson: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ARTDrugOrderImplCopyWith<$Res>
    implements $ARTDrugOrderCopyWith<$Res> {
  factory _$$ARTDrugOrderImplCopyWith(
          _$ARTDrugOrderImpl value, $Res Function(_$ARTDrugOrderImpl) then) =
      __$$ARTDrugOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      ARTEvent? event,
      ARTAppointment? appointment,
      Address deliveryAddress,
      String deliveryMethod,
      String phoneNumber,
      String? type,
      Courier? courierService,
      DeliveryPerson? deliveryPerson,
      String? createdAt,
      String? updateAt});

  @override
  $ARTEventCopyWith<$Res>? get event;
  @override
  $ARTAppointmentCopyWith<$Res>? get appointment;
  @override
  $AddressCopyWith<$Res> get deliveryAddress;
  @override
  $CourierCopyWith<$Res>? get courierService;
  @override
  $DeliveryPersonCopyWith<$Res>? get deliveryPerson;
}

/// @nodoc
class __$$ARTDrugOrderImplCopyWithImpl<$Res>
    extends _$ARTDrugOrderCopyWithImpl<$Res, _$ARTDrugOrderImpl>
    implements _$$ARTDrugOrderImplCopyWith<$Res> {
  __$$ARTDrugOrderImplCopyWithImpl(
      _$ARTDrugOrderImpl _value, $Res Function(_$ARTDrugOrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? event = freezed,
    Object? appointment = freezed,
    Object? deliveryAddress = null,
    Object? deliveryMethod = null,
    Object? phoneNumber = null,
    Object? type = freezed,
    Object? courierService = freezed,
    Object? deliveryPerson = freezed,
    Object? createdAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_$ARTDrugOrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ARTEvent?,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as ARTAppointment?,
      deliveryAddress: null == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      deliveryMethod: null == deliveryMethod
          ? _value.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      courierService: freezed == courierService
          ? _value.courierService
          : courierService // ignore: cast_nullable_to_non_nullable
              as Courier?,
      deliveryPerson: freezed == deliveryPerson
          ? _value.deliveryPerson
          : deliveryPerson // ignore: cast_nullable_to_non_nullable
              as DeliveryPerson?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTDrugOrderImpl with DiagnosticableTreeMixin implements _ARTDrugOrder {
  const _$ARTDrugOrderImpl(
      {this.id,
      this.event,
      this.appointment,
      required this.deliveryAddress,
      required this.deliveryMethod,
      required this.phoneNumber,
      this.type,
      this.courierService,
      this.deliveryPerson,
      this.createdAt,
      this.updateAt});

  factory _$ARTDrugOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTDrugOrderImplFromJson(json);

  @override
  final String? id;
  @override
  final ARTEvent? event;
  @override
  final ARTAppointment? appointment;
  @override
  final Address deliveryAddress;
  @override
  final String deliveryMethod;
  @override
  final String phoneNumber;
  @override
  final String? type;
  @override
  final Courier? courierService;
  @override
  final DeliveryPerson? deliveryPerson;
  @override
  final String? createdAt;
  @override
  final String? updateAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTDrugOrder(id: $id, event: $event, appointment: $appointment, deliveryAddress: $deliveryAddress, deliveryMethod: $deliveryMethod, phoneNumber: $phoneNumber, type: $type, courierService: $courierService, deliveryPerson: $deliveryPerson, createdAt: $createdAt, updateAt: $updateAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTDrugOrder'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('appointment', appointment))
      ..add(DiagnosticsProperty('deliveryAddress', deliveryAddress))
      ..add(DiagnosticsProperty('deliveryMethod', deliveryMethod))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('courierService', courierService))
      ..add(DiagnosticsProperty('deliveryPerson', deliveryPerson))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updateAt', updateAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTDrugOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.deliveryMethod, deliveryMethod) ||
                other.deliveryMethod == deliveryMethod) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.courierService, courierService) ||
                other.courierService == courierService) &&
            (identical(other.deliveryPerson, deliveryPerson) ||
                other.deliveryPerson == deliveryPerson) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      event,
      appointment,
      deliveryAddress,
      deliveryMethod,
      phoneNumber,
      type,
      courierService,
      deliveryPerson,
      createdAt,
      updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTDrugOrderImplCopyWith<_$ARTDrugOrderImpl> get copyWith =>
      __$$ARTDrugOrderImplCopyWithImpl<_$ARTDrugOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTDrugOrderImplToJson(
      this,
    );
  }
}

abstract class _ARTDrugOrder implements ARTDrugOrder {
  const factory _ARTDrugOrder(
      {final String? id,
      final ARTEvent? event,
      final ARTAppointment? appointment,
      required final Address deliveryAddress,
      required final String deliveryMethod,
      required final String phoneNumber,
      final String? type,
      final Courier? courierService,
      final DeliveryPerson? deliveryPerson,
      final String? createdAt,
      final String? updateAt}) = _$ARTDrugOrderImpl;

  factory _ARTDrugOrder.fromJson(Map<String, dynamic> json) =
      _$ARTDrugOrderImpl.fromJson;

  @override
  String? get id;
  @override
  ARTEvent? get event;
  @override
  ARTAppointment? get appointment;
  @override
  Address get deliveryAddress;
  @override
  String get deliveryMethod;
  @override
  String get phoneNumber;
  @override
  String? get type;
  @override
  Courier? get courierService;
  @override
  DeliveryPerson? get deliveryPerson;
  @override
  String? get createdAt;
  @override
  String? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$ARTDrugOrderImplCopyWith<_$ARTDrugOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
