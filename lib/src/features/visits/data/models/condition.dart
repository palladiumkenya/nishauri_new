import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'condition.freezed.dart';
part 'condition.g.dart';

@Freezed()
class Condition with _$Condition {
  const factory Condition({
    required String uuid,
    required String name,
    String? onsetDate,
    required String dateRecorded,
    required String status,
    required String value,
  }) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json)=> _$ConditionFromJson(json);
}