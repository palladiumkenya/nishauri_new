import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'art_group_subscription.freezed.dart';
part 'art_group_subscription.g.dart';

@Freezed()
class ARTGroupSubscription with _$ARTGroupSubscription {
  const factory ARTGroupSubscription({
    String? id,
    required String group,
    required String patient,
    String? name,
    @Default(false) bool? isCurrent,
  }) = _ARTGroupSubscription;

  factory ARTGroupSubscription.fromJson(Map<String, dynamic> json)=> _$ARTGroupSubscriptionFromJson(json);
}