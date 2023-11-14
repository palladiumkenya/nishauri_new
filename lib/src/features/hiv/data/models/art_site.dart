import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'art_site.freezed.dart';
part 'art_site.g.dart';

@Freezed()
class ARTSite with _$ARTSite {
  const factory ARTSite({
    required String mflCode,
    required String name,
    String? type,
    String? telephone,
  }) = _ARTSite;

  factory ARTSite.fromJson(Map<String, dynamic> json)=> _$ARTSiteFromJson(json);
}