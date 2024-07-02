import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/auth/data/models/section.dart';

part 'terms_privacy.freezed.dart';
part 'terms_privacy.g.dart';

@Freezed()
class TermsPrivacy with _$TermsPrivacy {
  const factory TermsPrivacy({
    String? title,
    String? introduction,
    List<Section>? sections,

  }) = _TermsPrivacy;
  factory TermsPrivacy.fromJson(Map<String, dynamic> json)=> _$TermsPrivacyFromJson(json);
}

