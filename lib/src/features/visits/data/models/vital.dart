import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'vital.freezed.dart';
part 'vital.g.dart';

@Freezed()
class Vital with _$Vital {
  const factory Vital({
    required String uuid,
    required String name,
    required String dateRecorded,
    required String value,
  }) = _Vital;

  factory Vital.fromJson(Map<String, dynamic> json)=> _$VitalFromJson(json);
}