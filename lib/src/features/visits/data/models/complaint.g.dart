// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplaintImpl _$$ComplaintImplFromJson(Map<String, dynamic> json) =>
    _$ComplaintImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      onsetDate: json['onsetDate'] as String?,
      dateRecorded: json['dateRecorded'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$ComplaintImplToJson(_$ComplaintImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'onsetDate': instance.onsetDate,
      'dateRecorded': instance.dateRecorded,
      'value': instance.value,
    };
