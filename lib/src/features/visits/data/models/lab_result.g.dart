// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabResultImpl _$$LabResultImplFromJson(Map<String, dynamic> json) =>
    _$LabResultImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      dateRecorded: json['dateRecorded'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$LabResultImplToJson(_$LabResultImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'dateRecorded': instance.dateRecorded,
      'value': instance.value,
    };
