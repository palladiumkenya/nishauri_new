import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'art_group.freezed.dart';
part 'art_group.g.dart';

@Freezed()
class ARTGroup with _$ARTGroup {
  const factory ARTGroup({
    String? id,
    required String title,
    String? description,
    required String lead,
  }) = _ARTGroup;

  factory ARTGroup.fromJson(Map<String, dynamic> json)=> _$ARTGroupFromJson(json);
}