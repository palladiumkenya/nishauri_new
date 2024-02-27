import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'art_group_extra_subscriber.freezed.dart';
part 'art_group_extra_subscriber.g.dart';

@Freezed()
class ARTGroupExtraSubscriber with _$ARTGroupExtraSubscriber {
  const factory ARTGroupExtraSubscriber({
    required String name,
    required String cccNumber,
    required String phoneNumber,
  }) = _ARTGroupExtraSubscriber;

  factory ARTGroupExtraSubscriber.fromJson(Map<String, dynamic> json)=> _$ARTGroupExtraSubscriberFromJson(json);
}