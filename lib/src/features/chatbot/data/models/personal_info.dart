import 'package:freezed_annotation/freezed_annotation.dart';
part 'personal_info.freezed.dart';
part 'personal_info.g.dart';

@Freezed()
class PersonalInfo with _$PersonalInfo {
  const factory PersonalInfo({
    String? gender,
    int? age,
    String? regimen,
    String? appointment_datetime,
    String? viral_load,
    String? viral_load_datetime,
  }) = _PersonalInfo;
  factory PersonalInfo.fromJson(Map<String, dynamic> json)=> _$PersonalInfoFromJson(json);
}
