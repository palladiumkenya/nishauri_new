// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_drug_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTDrugOrderImpl _$$ARTDrugOrderImplFromJson(Map<String, dynamic> json) =>
    _$ARTDrugOrderImpl(
      id: json['id'] as String?,
      event: json['event'] == null
          ? null
          : ARTEvent.fromJson(json['event'] as Map<String, dynamic>),
      appointment: json['appointment'] == null
          ? null
          : ARTAppointment.fromJson(
              json['appointment'] as Map<String, dynamic>),
      deliveryAddress:
          Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      deliveryMethod: json['deliveryMethod'] as String,
      phoneNumber: json['phoneNumber'] as String,
      type: json['type'] as String,
      courierService: json['courierService'] == null
          ? null
          : Courier.fromJson(json['courierService'] as Map<String, dynamic>),
      deliveryPerson: json['deliveryPerson'] == null
          ? null
          : DeliveryPerson.fromJson(
              json['deliveryPerson'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updateAt: json['updateAt'] as String?,
    );

Map<String, dynamic> _$$ARTDrugOrderImplToJson(_$ARTDrugOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'appointment': instance.appointment,
      'deliveryAddress': instance.deliveryAddress,
      'deliveryMethod': instance.deliveryMethod,
      'phoneNumber': instance.phoneNumber,
      'type': instance.type,
      'courierService': instance.courierService,
      'deliveryPerson': instance.deliveryPerson,
      'createdAt': instance.createdAt,
      'updateAt': instance.updateAt,
    };
