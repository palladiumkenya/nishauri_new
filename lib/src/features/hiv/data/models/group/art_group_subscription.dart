import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_member.dart';
part 'art_group_subscription.freezed.dart';
part 'art_group_subscription.g.dart';

@Freezed()
class ARTGroupSubscription with _$ARTGroupSubscription {
  const factory ARTGroupSubscription({
    String? id,
    required ARTGroup group,
    required ARTGroupMember user,
    String? publicName,
    required String createdAt,
    @Default(false) bool? isCurrent,
    @Default(false) bool? isAdmin,
  }) = _ARTGroupSubscription;

  factory ARTGroupSubscription.fromJson(Map<String, dynamic> json)=> _$ARTGroupSubscriptionFromJson(json);
}