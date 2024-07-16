// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BMILogImpl _$$BMILogImplFromJson(Map<String, dynamic> json) => _$BMILogImpl(
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$BMILogImplToJson(_$BMILogImpl instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'height': instance.height,
      'bmi': instance.bmi,
      'timestamp': instance.timestamp,
    };
