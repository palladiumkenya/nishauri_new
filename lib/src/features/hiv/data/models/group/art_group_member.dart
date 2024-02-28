import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
part 'art_group_member.freezed.dart';
part 'art_group_member.g.dart';

@Freezed()
class ARTGroupMember with _$ARTGroupMember {
  const factory ARTGroupMember({
    String? id,
  }) = _ARTGroupMember;

  factory ARTGroupMember.fromJson(Map<String, dynamic> json)=> _$ARTGroupMemberFromJson(json);
}