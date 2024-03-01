import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
part 'viral_load.freezed.dart';
// part 'viral_load.g.dart';
// @Freezed()
// class ViralLoad with _$ViralLoad {
//   const factory ViralLoad({
//     required String id,
//     required String result,
//     required String status,
//     required String date,
//     required String plot,
// }) = _ViralLoad;
//
//   factory ViralLoad.fromJson(Map<String, dynamic> json) => _$ViralLoadFromJson(json);
// }
@Freezed()
class ViralLoad with _$ViralLoad {
  const factory ViralLoad({
    required String id, // Add an id field
    required String result,
    required String status,
    required String date,
    required int plot,
  }) = _ViralLoad;

  factory ViralLoad.fromJson(Map<String, dynamic> json) {
    final uuid = const Uuid().v4();

    return ViralLoad(
      id: uuid,
      result: json['result'] != null ? json['result'] as String : '', // Handle nullable value
      status: json['status'] != null ? json['status'] as String : '', // Handle nullable value
      date: json['date'] != null ? json['date'] as String : '', // Handle nullable value
      plot: json['plot'] != null ? json['plot'] as int : 0, // Handle nullable value
    );
  }
}
