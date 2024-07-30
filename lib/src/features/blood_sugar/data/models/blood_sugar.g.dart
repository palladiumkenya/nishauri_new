// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BloodSugarImpl _$$BloodSugarImplFromJson(Map<String, dynamic> json) =>
    _$BloodSugarImpl(
      id: (json['id'] as num).toInt(),
      level: (json['level'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      condition: json['condition'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$BloodSugarImplToJson(_$BloodSugarImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'timestamp': instance.timestamp.toIso8601String(),
      'condition': instance.condition,
      'note': instance.note,
    };
