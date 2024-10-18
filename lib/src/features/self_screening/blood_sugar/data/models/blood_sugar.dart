import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_sugar.freezed.dart';
part 'blood_sugar.g.dart';

@freezed
class BloodSugar with _$BloodSugar {
  const factory BloodSugar({
    required final double level,
    required final DateTime created_at,
    required final String condition,
    final String? notes,
  }) = _BloodSugar;

  factory BloodSugar.fromJson(Map<String, dynamic> json) =>
      _$BloodSugarFromJson(json);
}
