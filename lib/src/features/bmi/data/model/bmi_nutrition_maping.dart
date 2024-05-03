import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'bmi_nutrition_maping.freezed.dart';
part 'bmi_nutrition_maping.g.dart';

@Freezed()
class BMIStatusNutrition with _$BMIStatusNutrition {
  const factory BMIStatusNutrition({
    String? id,
    required String status,
    required String description,
    required String createdAt,
    required bool isActive,
    required String updatedAt,
    String? deletedAt,
  }) = _BMIStatusNutrition;

  factory BMIStatusNutrition.fromJson(Map<String, dynamic> json)=> _$BMIStatusNutritionFromJson(json);
}
