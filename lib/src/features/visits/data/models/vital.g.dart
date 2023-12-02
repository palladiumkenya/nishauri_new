// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VitalImpl _$$VitalImplFromJson(Map<String, dynamic> json) => _$VitalImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      dateRecorded: json['dateRecorded'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$VitalImplToJson(_$VitalImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'dateRecorded': instance.dateRecorded,
      'value': instance.value,
    };
