import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/blood_pressure_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/blood_pressure_record.dart';
import 'package:nishauri/src/features/bp/data/data_util/repository_builder.dart';
import 'package:nishauri/src/features/bp/data/models/storage/intervall_store.dart';

/// Shorthand class for getting the blood pressure values.
class BloodPressureBuilder extends StatelessWidget {
  /// Create a loader for the measurements in the current range.
  const BloodPressureBuilder({
    super.key,
    required this.onData,
    required this.rangeType,
  });

  /// The build strategy once the measurement are loaded.
  final Widget Function(BuildContext context, UnmodifiableListView<BloodPressureRecord> records) onData;

  /// Which measurements to load.
  final IntervallStoreManagerLocation rangeType;
  
  @override
  Widget build(BuildContext context) =>
    RepositoryBuilder<BloodPressureRecord, BloodPressureRepository>(
      rangeType: rangeType,
      onData: (context, List<BloodPressureRecord> data) =>
        onData(context, UnmodifiableListView(data)),
  );
  
}
