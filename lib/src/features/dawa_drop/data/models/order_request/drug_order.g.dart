// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrugOrderImpl _$$DrugOrderImplFromJson(Map<String, dynamic> json) =>
    _$DrugOrderImpl(
      order_id: json['order_id'] as int?,
      appointment: json['appointment'] == null
          ? null
          : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
      deliveryAddress: json['deliveryAddress'] == null
          ? null
          : Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      delivery_method: json['delivery_method'] as String?,
      client_phone_no: json['client_phone_no'] as String?,
      order_type: json['order_type'] as String?,
      courierService: json['courierService'] == null
          ? null
          : Courier.fromJson(json['courierService'] as Map<String, dynamic>),
      deliveryPerson: json['deliveryPerson'] == null
          ? null
          : DeliveryPerson.fromJson(
              json['deliveryPerson'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updateAt: json['updateAt'] as String?,
      status: json['status'] as String?,
      approved_date: json['approved_date'] as String?,
      dispatched_date: json['dispatched_date'] as String?,
      fullfilled_date: json['fullfilled_date'] as String?,
      date_order_posted: json['date_order_posted'] as String?,
    );

Map<String, dynamic> _$$DrugOrderImplToJson(_$DrugOrderImpl instance) =>
    <String, dynamic>{
      'order_id': instance.order_id,
      'appointment': instance.appointment,
      'deliveryAddress': instance.deliveryAddress,
      'delivery_method': instance.delivery_method,
      'client_phone_no': instance.client_phone_no,
      'order_type': instance.order_type,
      'courierService': instance.courierService,
      'deliveryPerson': instance.deliveryPerson,
      'createdAt': instance.createdAt,
      'updateAt': instance.updateAt,
      'status': instance.status,
      'approved_date': instance.approved_date,
      'dispatched_date': instance.dispatched_date,
      'fullfilled_date': instance.fullfilled_date,
      'date_order_posted': instance.date_order_posted,
    };
