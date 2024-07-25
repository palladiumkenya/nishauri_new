import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_sugar.freezed.dart';
part 'blood_sugar.g.dart';

@freezed
class BloodSugar with _$BloodSugar {
  const factory BloodSugar({
    required int id,
    required double level,
    required DateTime timestamp,
    required String note,
  }) = _BloodSugar;

  factory BloodSugar.fromJson(Map<String, dynamic> json) =>
      _$BloodSugarFromJson(json);
}
