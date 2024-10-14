// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_registry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderRegistryImpl _$$ProviderRegistryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProviderRegistryImpl(
      id: (json['id'] as num?)?.toInt(),
      family_name: json['family_name'] as String?,
      given_name: json['given_name'] as String?,
      national_id: (json['national_id'] as num?)?.toInt(),
      licence_number: json['licence_number'] as String?,
      board_number: json['board_number'] as String?,
      cadre: json['cadre'] as String?,
      gender: json['gender'] as String?,
      facility_code: json['facility_code'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
      salutation: json['salutation'] as String?,
    );

Map<String, dynamic> _$$ProviderRegistryImplToJson(
        _$ProviderRegistryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family_name': instance.family_name,
      'given_name': instance.given_name,
      'national_id': instance.national_id,
      'licence_number': instance.licence_number,
      'board_number': instance.board_number,
      'cadre': instance.cadre,
      'gender': instance.gender,
      'facility_code': instance.facility_code,
      'user_id': instance.user_id,
      'salutation': instance.salutation,
    };
