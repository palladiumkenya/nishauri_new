import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/visits/data/models/allergy.dart';
import 'package:nishauri/src/features/visits/data/models/complaint.dart';
import 'package:nishauri/src/features/visits/data/models/condition.dart';
import 'package:nishauri/src/features/visits/data/models/diagnosis.dart';
import 'package:nishauri/src/features/visits/data/models/lab_result.dart';
import 'package:nishauri/src/features/visits/data/models/vital.dart';
part 'visit.freezed.dart';
part 'visit.g.dart';

@Freezed()
class Visit with _$Visit {
  const factory Visit({
    required String uuid,
    @Default([]) List<Allergy> allergies,
    @Default([]) List<Complaint> complaints,
    @Default([]) List<Condition> conditions,
    @Default([]) List<Diagnosis> diagnosis,
    @Default([]) List<LabResult> labResults,
    @Default([]) List<Vital> vitals,
    required String visitDate,
  }) = _Visit;

  factory Visit.fromJson(Map<String, dynamic> json)=> _$VisitFromJson(json);
}