import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/units/pressure.dart';

part 'blood_pressure_record.freezed.dart';

/// Immutable representation of a blood pressure measurement.
@freezed
class BloodPressureRecord with _$BloodPressureRecord {
  /// Create a immutable representation of a blood pressure measurement.
  const factory BloodPressureRecord({
    /// Timestamp when the measurement was taken.
    required DateTime time,
    /// Systolic value of the measurement.
    Pressure? sys,
    /// Diastolic value of the measurement.
    Pressure? dia,
    /// Pulse value of the measurement in bpm.
    int? pul,
  }) = _BloodPressureRecord;
}
