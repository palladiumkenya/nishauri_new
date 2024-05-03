// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliveryPersonImpl _$$DeliveryPersonImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryPersonImpl(
      fullName: json['fullName'] as String?,
      nationalId: json['nationalId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      pickupTime: json['pickupTime'] as String?,
    );

Map<String, dynamic> _$$DeliveryPersonImplToJson(
        _$DeliveryPersonImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'nationalId': instance.nationalId,
      'phoneNumber': instance.phoneNumber,
      'pickupTime': instance.pickupTime,
    };
