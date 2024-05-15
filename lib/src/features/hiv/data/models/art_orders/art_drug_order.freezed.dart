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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ARTDrugOrder _$ARTDrugOrderFromJson(Map<String, dynamic> json) {
  return _ARTDrugOrder.fromJson(json);
}

/// @nodoc
mixin _$ARTDrugOrder {
  int? get order_id => throw _privateConstructorUsedError;
  ARTEvent? get event => throw _privateConstructorUsedError;
  ARTAppointment? get appointment => throw _privateConstructorUsedError;
  Address? get deliveryAddress => throw _privateConstructorUsedError;
  String? get delivery_method => throw _privateConstructorUsedError;
  String? get client_phone_no => throw _privateConstructorUsedError;
  String? get order_type => throw _privateConstructorUsedError;
  Courier? get courierService => throw _privateConstructorUsedError;
  DeliveryPerson? get deliveryPerson => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updateAt => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get approved_date => throw _privateConstructorUsedError;
  String? get dispatched_date => throw _privateConstructorUsedError;
  String? get fullfilled_date => throw _privateConstructorUsedError;
  String? get date_order_posted => throw _privateConstructorUsedError;

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
      {int? order_id,
      ARTEvent? event,
      ARTAppointment? appointment,
      Address? deliveryAddress,
      String? delivery_method,
      String? client_phone_no,
      String? order_type,
      Courier? courierService,
      DeliveryPerson? deliveryPerson,
      String? createdAt,
      String? updateAt,
      String? status,
      String? approved_date,
      String? dispatched_date,
      String? fullfilled_date,
      String? date_order_posted});

  $ARTEventCopyWith<$Res>? get event;
  $ARTAppointmentCopyWith<$Res>? get appointment;
  $AddressCopyWith<$Res>? get deliveryAddress;
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
    Object? order_id = freezed,
    Object? event = freezed,
    Object? appointment = freezed,
    Object? deliveryAddress = freezed,
    Object? delivery_method = freezed,
    Object? client_phone_no = freezed,
    Object? order_type = freezed,
    Object? courierService = freezed,
    Object? deliveryPerson = freezed,
    Object? createdAt = freezed,
    Object? updateAt = freezed,
    Object? status = freezed,
    Object? approved_date = freezed,
    Object? dispatched_date = freezed,
    Object? fullfilled_date = freezed,
    Object? date_order_posted = freezed,
  }) {
    return _then(_value.copyWith(
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ARTEvent?,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as ARTAppointment?,
      deliveryAddress: freezed == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      delivery_method: freezed == delivery_method
          ? _value.delivery_method
          : delivery_method // ignore: cast_nullable_to_non_nullable
              as String?,
      client_phone_no: freezed == client_phone_no
          ? _value.client_phone_no
          : client_phone_no // ignore: cast_nullable_to_non_nullable
              as String?,
      order_type: freezed == order_type
          ? _value.order_type
          : order_type // ignore: cast_nullable_to_non_nullable
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      approved_date: freezed == approved_date
          ? _value.approved_date
          : approved_date // ignore: cast_nullable_to_non_nullable
              as String?,
      dispatched_date: freezed == dispatched_date
          ? _value.dispatched_date
          : dispatched_date // ignore: cast_nullable_to_non_nullable
              as String?,
      fullfilled_date: freezed == fullfilled_date
          ? _value.fullfilled_date
          : fullfilled_date // ignore: cast_nullable_to_non_nullable
              as String?,
      date_order_posted: freezed == date_order_posted
          ? _value.date_order_posted
          : date_order_posted // ignore: cast_nullable_to_non_nullable
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
  $AddressCopyWith<$Res>? get deliveryAddress {
    if (_value.deliveryAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.deliveryAddress!, (value) {
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
      {int? order_id,
      ARTEvent? event,
      ARTAppointment? appointment,
      Address? deliveryAddress,
      String? delivery_method,
      String? client_phone_no,
      String? order_type,
      Courier? courierService,
      DeliveryPerson? deliveryPerson,
      String? createdAt,
      String? updateAt,
      String? status,
      String? approved_date,
      String? dispatched_date,
      String? fullfilled_date,
      String? date_order_posted});

  @override
  $ARTEventCopyWith<$Res>? get event;
  @override
  $ARTAppointmentCopyWith<$Res>? get appointment;
  @override
  $AddressCopyWith<$Res>? get deliveryAddress;
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
    Object? order_id = freezed,
    Object? event = freezed,
    Object? appointment = freezed,
    Object? deliveryAddress = freezed,
    Object? delivery_method = freezed,
    Object? client_phone_no = freezed,
    Object? order_type = freezed,
    Object? courierService = freezed,
    Object? deliveryPerson = freezed,
    Object? createdAt = freezed,
    Object? updateAt = freezed,
    Object? status = freezed,
    Object? approved_date = freezed,
    Object? dispatched_date = freezed,
    Object? fullfilled_date = freezed,
    Object? date_order_posted = freezed,
  }) {
    return _then(_$ARTDrugOrderImpl(
      order_id: freezed == order_id
          ? _value.order_id
          : order_id // ignore: cast_nullable_to_non_nullable
              as int?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ARTEvent?,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as ARTAppointment?,
      deliveryAddress: freezed == deliveryAddress
          ? _value.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      delivery_method: freezed == delivery_method
          ? _value.delivery_method
          : delivery_method // ignore: cast_nullable_to_non_nullable
              as String?,
      client_phone_no: freezed == client_phone_no
          ? _value.client_phone_no
          : client_phone_no // ignore: cast_nullable_to_non_nullable
              as String?,
      order_type: freezed == order_type
          ? _value.order_type
          : order_type // ignore: cast_nullable_to_non_nullable
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      approved_date: freezed == approved_date
          ? _value.approved_date
          : approved_date // ignore: cast_nullable_to_non_nullable
              as String?,
      dispatched_date: freezed == dispatched_date
          ? _value.dispatched_date
          : dispatched_date // ignore: cast_nullable_to_non_nullable
              as String?,
      fullfilled_date: freezed == fullfilled_date
          ? _value.fullfilled_date
          : fullfilled_date // ignore: cast_nullable_to_non_nullable
              as String?,
      date_order_posted: freezed == date_order_posted
          ? _value.date_order_posted
          : date_order_posted // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTDrugOrderImpl with DiagnosticableTreeMixin implements _ARTDrugOrder {
  const _$ARTDrugOrderImpl(
      {this.order_id,
      this.event,
      this.appointment,
      this.deliveryAddress,
      this.delivery_method,
      this.client_phone_no,
      this.order_type,
      this.courierService,
      this.deliveryPerson,
      this.createdAt,
      this.updateAt,
      this.status,
      this.approved_date,
      this.dispatched_date,
      this.fullfilled_date,
      this.date_order_posted});

  factory _$ARTDrugOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTDrugOrderImplFromJson(json);

  @override
  final int? order_id;
  @override
  final ARTEvent? event;
  @override
  final ARTAppointment? appointment;
  @override
  final Address? deliveryAddress;
  @override
  final String? delivery_method;
  @override
  final String? client_phone_no;
  @override
  final String? order_type;
  @override
  final Courier? courierService;
  @override
  final DeliveryPerson? deliveryPerson;
  @override
  final String? createdAt;
  @override
  final String? updateAt;
  @override
  final String? status;
  @override
  final String? approved_date;
  @override
  final String? dispatched_date;
  @override
  final String? fullfilled_date;
  @override
  final String? date_order_posted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTDrugOrder(order_id: $order_id, event: $event, appointment: $appointment, deliveryAddress: $deliveryAddress, delivery_method: $delivery_method, client_phone_no: $client_phone_no, order_type: $order_type, courierService: $courierService, deliveryPerson: $deliveryPerson, createdAt: $createdAt, updateAt: $updateAt, status: $status, approved_date: $approved_date, dispatched_date: $dispatched_date, fullfilled_date: $fullfilled_date, date_order_posted: $date_order_posted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTDrugOrder'))
      ..add(DiagnosticsProperty('order_id', order_id))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('appointment', appointment))
      ..add(DiagnosticsProperty('deliveryAddress', deliveryAddress))
      ..add(DiagnosticsProperty('delivery_method', delivery_method))
      ..add(DiagnosticsProperty('client_phone_no', client_phone_no))
      ..add(DiagnosticsProperty('order_type', order_type))
      ..add(DiagnosticsProperty('courierService', courierService))
      ..add(DiagnosticsProperty('deliveryPerson', deliveryPerson))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updateAt', updateAt))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('approved_date', approved_date))
      ..add(DiagnosticsProperty('dispatched_date', dispatched_date))
      ..add(DiagnosticsProperty('fullfilled_date', fullfilled_date))
      ..add(DiagnosticsProperty('date_order_posted', date_order_posted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTDrugOrderImpl &&
            (identical(other.order_id, order_id) ||
                other.order_id == order_id) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.delivery_method, delivery_method) ||
                other.delivery_method == delivery_method) &&
            (identical(other.client_phone_no, client_phone_no) ||
                other.client_phone_no == client_phone_no) &&
            (identical(other.order_type, order_type) ||
                other.order_type == order_type) &&
            (identical(other.courierService, courierService) ||
                other.courierService == courierService) &&
            (identical(other.deliveryPerson, deliveryPerson) ||
                other.deliveryPerson == deliveryPerson) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approved_date, approved_date) ||
                other.approved_date == approved_date) &&
            (identical(other.dispatched_date, dispatched_date) ||
                other.dispatched_date == dispatched_date) &&
            (identical(other.fullfilled_date, fullfilled_date) ||
                other.fullfilled_date == fullfilled_date) &&
            (identical(other.date_order_posted, date_order_posted) ||
                other.date_order_posted == date_order_posted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      order_id,
      event,
      appointment,
      deliveryAddress,
      delivery_method,
      client_phone_no,
      order_type,
      courierService,
      deliveryPerson,
      createdAt,
      updateAt,
      status,
      approved_date,
      dispatched_date,
      fullfilled_date,
      date_order_posted);

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
      {final int? order_id,
      final ARTEvent? event,
      final ARTAppointment? appointment,
      final Address? deliveryAddress,
      final String? delivery_method,
      final String? client_phone_no,
      final String? order_type,
      final Courier? courierService,
      final DeliveryPerson? deliveryPerson,
      final String? createdAt,
      final String? updateAt,
      final String? status,
      final String? approved_date,
      final String? dispatched_date,
      final String? fullfilled_date,
      final String? date_order_posted}) = _$ARTDrugOrderImpl;

  factory _ARTDrugOrder.fromJson(Map<String, dynamic> json) =
      _$ARTDrugOrderImpl.fromJson;

  @override
  int? get order_id;
  @override
  ARTEvent? get event;
  @override
  ARTAppointment? get appointment;
  @override
  Address? get deliveryAddress;
  @override
  String? get delivery_method;
  @override
  String? get client_phone_no;
  @override
  String? get order_type;
  @override
  Courier? get courierService;
  @override
  DeliveryPerson? get deliveryPerson;
  @override
  String? get createdAt;
  @override
  String? get updateAt;
  @override
  String? get status;
  @override
  String? get approved_date;
  @override
  String? get dispatched_date;
  @override
  String? get fullfilled_date;
  @override
  String? get date_order_posted;
  @override
  @JsonKey(ignore: true)
  _$$ARTDrugOrderImplCopyWith<_$ARTDrugOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
