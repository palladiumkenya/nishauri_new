// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConditionImpl _$$ConditionImplFromJson(Map<String, dynamic> json) =>
    _$ConditionImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      onsetDate: json['onsetDate'] as String?,
      dateRecorded: json['dateRecorded'] as String,
      status: json['status'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$ConditionImplToJson(_$ConditionImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'onsetDate': instance.onsetDate,
      'dateRecorded': instance.dateRecorded,
      'status': instance.status,
      'value': instance.value,
    };
