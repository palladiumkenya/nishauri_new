import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@Freezed()
class Location with _$Location {
  const factory Location({
    int? county_id,
    int? sub_county_id,
    String? sub_county_name,
    String? county_name,
    String? facility_name,
    int? mfl_code,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json)=> _$LocationFromJson(json);
}