import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nishauri/src/features/clinic_card/data/models/PatientObservation.dart';
import 'package:uuid/uuid.dart';
part 'program.freezed.dart';


@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String name,
    String? facility_name,
    required List<PatientObservation> obs,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) {
    final uuid = const Uuid().v4();
    return Program(
      id:uuid,
      name: json['name'],
      facility_name: json['facility'],
      obs: (json['patient_observations'] as List<dynamic>? ?? [])
          .map((obsJson) => PatientObservation.fromJson(obsJson))
          .toList(),
    );
  }
}
