// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BloodSugarImpl _$$BloodSugarImplFromJson(Map<String, dynamic> json) =>
    _$BloodSugarImpl(
      level: (json['level'] as num).toDouble(),
      created_at: DateTime.parse(json['created_at'] as String),
      condition: json['condition'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$BloodSugarImplToJson(_$BloodSugarImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'created_at': instance.created_at.toIso8601String(),
      'condition': instance.condition,
      'notes': instance.notes,
    };
