// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_regimen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTRegimenImpl _$$ARTRegimenImplFromJson(Map<String, dynamic> json) =>
    _$ARTRegimenImpl(
      id: json['id'] as String?,
      regimen: json['regimen'] as String,
      description: json['description'] as String?,
      ccc_no: json['ccc_no'] as String?,
      isCurrent: json['isCurrent'] as bool? ?? false,
    );

Map<String, dynamic> _$$ARTRegimenImplToJson(_$ARTRegimenImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regimen': instance.regimen,
      'description': instance.description,
      'ccc_no': instance.ccc_no,
      'isCurrent': instance.isCurrent,
    };
