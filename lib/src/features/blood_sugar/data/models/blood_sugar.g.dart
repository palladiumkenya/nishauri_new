// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BloodSugarImpl _$$BloodSugarImplFromJson(Map<String, dynamic> json) =>
    _$BloodSugarImpl(
      level: (json['level'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      condition: json['condition'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$BloodSugarImplToJson(_$BloodSugarImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'date': instance.date.toIso8601String(),
      'condition': instance.condition,
      'notes': instance.notes,
    };
