import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/auth/data/models/section.dart';

part 'terms_conditions.freezed.dart';
part 'terms_conditions.g.dart';

@Freezed()
class TermsConditions with _$TermsConditions {
  const factory TermsConditions({
    String? title,
    String? introduction,
    List<Section>? sections,

}) = _TermsConditions;
  factory TermsConditions.fromJson(Map<String, dynamic> json)=> _$TermsConditionsFromJson(json);
}

