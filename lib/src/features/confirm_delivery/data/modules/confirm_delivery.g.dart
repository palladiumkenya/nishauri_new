// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfirmDeliveryImpl _$$ConfirmDeliveryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmDeliveryImpl(
      id: json['id'] as String?,
      order_id: json['order_id'] as int?,
      confirmation_code: json['confirmation_code'] as String,
      is_received: json['is_received'] as int,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$ConfirmDeliveryImplToJson(
        _$ConfirmDeliveryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.order_id,
      'confirmation_code': instance.confirmation_code,
      'is_received': instance.is_received,
      'comment': instance.comment,
    };
