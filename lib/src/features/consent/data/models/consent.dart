import 'package:freezed_annotation/freezed_annotation.dart';

part 'consent.freezed.dart';
part 'consent.g.dart';


@Freezed()
class Consent with _$Consent {
  const factory Consent({
    String? user_id,
    required int isConsent,
  }) = _Consent;

  factory Consent.fromJson(Map<String, dynamic> json)=> _$ConsentFromJson(json);
}
