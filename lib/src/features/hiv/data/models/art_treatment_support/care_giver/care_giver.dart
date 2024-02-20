import 'package:freezed_annotation/freezed_annotation.dart';
part 'care_giver.freezed.dart';
part 'care_giver.g.dart';

@Freezed()
class CareGiver with _$CareGiver {
  const factory CareGiver({
    required String name,
  }) = _CareGiver;

  factory CareGiver.fromJson(Map<String, dynamic> json)=> _$CareGiverFromJson(json);
}