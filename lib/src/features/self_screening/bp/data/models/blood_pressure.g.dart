// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BloodPressureImpl _$$BloodPressureImplFromJson(Map<String, dynamic> json) =>
    _$BloodPressureImpl(
      systolic: (json['systolic'] as num).toDouble(),
      diastolic: (json['diastolic'] as num).toDouble(),
      pulse_rate: (json['pulse_rate'] as num).toDouble(),
      notes: json['notes'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$BloodPressureImplToJson(_$BloodPressureImpl instance) =>
    <String, dynamic>{
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'pulse_rate': instance.pulse_rate,
      'notes': instance.notes,
      'created_at': instance.created_at.toIso8601String(),
    };
