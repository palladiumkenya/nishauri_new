import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/hiv/data/models/models.dart';
part 'art_event.freezed.dart';
part 'art_event.g.dart';

@Freezed()
class ARTEvent with _$ARTEvent {
  const factory ARTEvent({
    String? id,
    required String title,
    required String distributionTime,
    required Address distributionLocation,
    @Default([]) List<String>? reminderNotificationDates,
    required ARTGroup group,
  }) = _ARTEvent;

  factory ARTEvent.fromJson(Map<String, dynamic> json)=> _$ARTEventFromJson(json);
}