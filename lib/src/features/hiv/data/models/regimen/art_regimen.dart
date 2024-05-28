import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'art_regimen.freezed.dart';
part 'art_regimen.g.dart';

@Freezed()
class ARTRegimen with _$ARTRegimen {
  const factory ARTRegimen({
    String? id,
    required String regimen,
    String? description,
    String? ccc_no,
    @Default(false) bool isCurrent,
  }) = _ARTRegimen;

  factory ARTRegimen.fromJson(Map<String, dynamic> json)=> _$ARTRegimenFromJson(json);
}