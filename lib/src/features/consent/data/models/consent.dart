import 'package:freezed_annotation/freezed_annotation.dart';

part 'consent.freezed.dart';
part 'consent.g.dart';


@Freezed()
class Consent with _$Consent {
  const factory Consent({
    String? user_id,
    required String chatbot_consent,
    String? chatbot_consent_date,

  }) = _Consent;

  factory Consent.fromJson(Map<String, dynamic> json)=> _$ConsentFromJson(json);
}
