import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'diagnosis.freezed.dart';
part 'diagnosis.g.dart';

@Freezed()
class Diagnosis with _$Diagnosis {
  const factory Diagnosis({
    required String uuid,
    required String name,
    required String dateRecorded,
    required String value,
  }) = _Diagnosis;

  factory Diagnosis.fromJson(Map<String, dynamic> json)=> _$DiagnosisFromJson(json);
}