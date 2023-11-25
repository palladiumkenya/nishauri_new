import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'complaint.freezed.dart';
part 'complaint.g.dart';

@Freezed()
class Complaint with _$Complaint {
  const factory Complaint({
    required String uuid,
    required String name,
    String? onsetDate,
    required String dateRecorded,
    required String value,
  }) = _Complaint;

  factory Complaint.fromJson(Map<String, dynamic> json)=> _$ComplaintFromJson(json);
}