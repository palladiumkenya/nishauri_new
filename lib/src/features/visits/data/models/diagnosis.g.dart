// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiagnosisImpl _$$DiagnosisImplFromJson(Map<String, dynamic> json) =>
    _$DiagnosisImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      dateRecorded: json['dateRecorded'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$DiagnosisImplToJson(_$DiagnosisImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'dateRecorded': instance.dateRecorded,
      'value': instance.value,
    };
