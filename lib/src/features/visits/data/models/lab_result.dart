import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'lab_result.freezed.dart';
part 'lab_result.g.dart';

@Freezed()
class LabResult with _$LabResult {
  const factory LabResult({
    required String uuid,
    required String name,
    required String dateRecorded,
    required String value,
  }) = _LabResult;

  factory LabResult.fromJson(Map<String, dynamic> json)=> _$LabResultFromJson(json);
}