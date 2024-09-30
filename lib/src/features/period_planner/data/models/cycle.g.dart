// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CycleImpl _$$CycleImplFromJson(Map<String, dynamic> json) => _$CycleImpl(
      period_start: DateTime.parse(json['period_start'] as String),
      period_end: DateTime.parse(json['period_end'] as String),
      fertile_start: DateTime.parse(json['fertile_start'] as String),
      fertile_end: DateTime.parse(json['fertile_end'] as String),
      ovulation: DateTime.parse(json['ovulation'] as String),
      predicted_period_start:
          DateTime.parse(json['predicted_period_start'] as String),
      predicted_period_end:
          DateTime.parse(json['predicted_period_end'] as String),
      cycle_length: (json['cycle_length'] as num).toInt(),
      period_length: (json['period_length'] as num).toInt(),
    );

Map<String, dynamic> _$$CycleImplToJson(_$CycleImpl instance) =>
    <String, dynamic>{
      'period_start': instance.period_start.toIso8601String(),
      'period_end': instance.period_end.toIso8601String(),
      'fertile_start': instance.fertile_start.toIso8601String(),
      'fertile_end': instance.fertile_end.toIso8601String(),
      'ovulation': instance.ovulation.toIso8601String(),
      'predicted_period_start':
          instance.predicted_period_start.toIso8601String(),
      'predicted_period_end': instance.predicted_period_end.toIso8601String(),
      'cycle_length': instance.cycle_length,
      'period_length': instance.period_length,
    };
