import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmi_log.freezed.dart';
part 'bmi_log.g.dart';

@Freezed()
class BMILog with _$BMILog {

  const factory BMILog({
    required String weight,
    required String height,
    required String bmi,
  }) = _BMILog;

  factory BMILog.fromJson(Map<String, Object?> json)
    => _$BMILogFromJson(json);
}