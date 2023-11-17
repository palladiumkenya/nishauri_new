// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTSiteImpl _$$ARTSiteImplFromJson(Map<String, dynamic> json) =>
    _$ARTSiteImpl(
      id: json['id'] as String?,
      mflCode: json['mflCode'] as String,
      name: json['name'] as String,
      type: json['type'] as String?,
      telephone: json['telephone'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ARTSiteImplToJson(_$ARTSiteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mflCode': instance.mflCode,
      'name': instance.name,
      'type': instance.type,
      'telephone': instance.telephone,
      'address': instance.address,
    };
