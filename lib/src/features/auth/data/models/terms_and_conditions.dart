import 'package:nishauri/src/features/auth/data/models/terms_conditions.dart';
import 'package:nishauri/src/features/auth/data/models/terms_privacy.dart';

class TermsAndPrivacy {
  final TermsConditions termsConditions;
  final TermsPrivacy privacyPolicy;

  TermsAndPrivacy({required this.termsConditions, required this.privacyPolicy});

  factory TermsAndPrivacy.fromJson(Map<String, dynamic> json) {
    return TermsAndPrivacy(
      termsConditions: TermsConditions.fromJson(json['termsConditions']),
      privacyPolicy: TermsPrivacy.fromJson(json['privacyPolicy']),
    );
  }
}