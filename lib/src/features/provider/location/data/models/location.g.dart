// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      county_id: (json['county_id'] as num?)?.toInt(),
      sub_county_id: (json['sub_county_id'] as num?)?.toInt(),
      sub_county_name: json['sub_county_name'] as String?,
      county_name: json['county_name'] as String?,
      facility_name: json['facility_name'] as String?,
      mfl_code: (json['mfl_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'county_id': instance.county_id,
      'sub_county_id': instance.sub_county_id,
      'sub_county_name': instance.sub_county_name,
      'county_name': instance.county_name,
      'facility_name': instance.facility_name,
      'mfl_code': instance.mfl_code,
    };
