// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BMILogImpl _$$BMILogImplFromJson(Map<String, dynamic> json) => _$BMILogImpl(
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      results: (json['results'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$$BMILogImplToJson(_$BMILogImpl instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'height': instance.height,
      'results': instance.results,
      'date': instance.date,
    };
