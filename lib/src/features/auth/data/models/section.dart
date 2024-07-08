import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@Freezed()
class Section with _$Section {
  const factory Section({
    String? header,
    List<String>? content,
  }) = _Section;
  factory Section.fromJson(Map<String, dynamic> json)=> _$SectionFromJson(json);
}