import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/address.dart';
part 'art_site.freezed.dart';
part 'art_site.g.dart';

@Freezed()
class ARTSite with _$ARTSite {
  const factory ARTSite({
    String? id,
    required String mflCode,
    required String name,
    String? type,
    String? telephone,
    required Address address
  }) = _ARTSite;

  factory ARTSite.fromJson(Map<String, dynamic> json)=> _$ARTSiteFromJson(json);
}