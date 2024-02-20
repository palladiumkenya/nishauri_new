import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/art_treatment_support/care_giver/care_giver.dart';
import 'package:nishauri/src/features/hiv/data/models/art_treatment_support/care_receiver/care_receiver.dart';

part 'art_treatment_support.freezed.dart';
part 'art_treatment_support.g.dart';

@Freezed()
class ARTTreatmentSupport with _$ARTTreatmentSupport {
  const factory ARTTreatmentSupport({
    String? id,
    required CareReceiver careReceiver,
    required CareGiver careGiver,

  }) = _ARTTreatmentSupport;

  factory ARTTreatmentSupport.fromJson(Map<String, dynamic> json)=> _$ARTTreatmentSupportFromJson(json);
}