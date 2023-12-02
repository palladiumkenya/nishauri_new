import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
part 'art_group_lead.freezed.dart';
part 'art_group_lead.g.dart';

@Freezed()
class ARTGroupLead with _$ARTGroupLead {
  const factory ARTGroupLead({
    String? id,
    required String group,
    required String user,
  }) = _ARTGroupLead;

  factory ARTGroupLead.fromJson(Map<String, dynamic> json)=> _$ARTGroupLeadFromJson(json);
}