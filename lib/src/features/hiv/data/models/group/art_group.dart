import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_extra_subscriber.dart';
part 'art_group.freezed.dart';
part 'art_group.g.dart';

@Freezed()
class ARTGroup with _$ARTGroup {
  const factory ARTGroup({
    String? id,
    required String title,
    String? description,
    @Default([]) List<ARTGroupExtraSubscriber> extraSubscribers,
    required String createdAt,
    required String updatedAt,
  }) = _ARTGroup;

  factory ARTGroup.fromJson(Map<String, dynamic> json)=> _$ARTGroupFromJson(json);
}