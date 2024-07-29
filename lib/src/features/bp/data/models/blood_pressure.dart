import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'blood_pressure.freezed.dart';
part 'blood_pressure.g.dart';

@Freezed()
class BloodPressure with _$BloodPressure {
  const factory BloodPressure({
    required double systolic,
    required double diastolic,
    required double pulse_rate,
    String? notes,
    required DateTime date_time,

  }) = _BloodPressure;
  factory BloodPressure.fromJson(Map<String, dynamic> json)=> _$BloodPressureFromJson(json);
}