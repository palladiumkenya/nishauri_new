import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'allergy.freezed.dart';
part 'allergy.g.dart';

@Freezed()
class Allergy with _$Allergy {
  const factory Allergy({
    required String uuid,
    required String allergen,
    required String reaction,
    String? onsetDate,
    required String dateRecorded,
    required String severity,
  }) = _Allergy;

  factory Allergy.fromJson(Map<String, dynamic> json)=> _$AllergyFromJson(json);
}