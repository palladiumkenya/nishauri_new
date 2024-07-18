import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/blood_pressure_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/medicine_intake_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/medicine_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/note_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/blood_pressure_record.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/medicine_intake.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/note.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/medicine.dart' as medicin;
import 'package:nishauri/src/features/bp/data/data_store/types/units/pressure.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/units/weight.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure/model.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure/record.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/pages/error_reporting_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'medicine/intake_history.dart';
import 'medicine/medicine.dart';

/// Loads data from old storage locations, adds them to new repos and deletes old storage location on success.
@Deprecated('Only use to migrate legacy data')
Future<void> updateLegacyEntries(
  Settings settings,
  BloodPressureRepository bpRepo,
  NoteRepository noteRepo,
  MedicineRepository medRepo,
  MedicineIntakeRepository intakeRepo,
) async {
  // Migrate old meds still in use and old intakes
  try {
    if (settings.medications.isNotEmpty) {
      final intakeString = File(join(await getDatabasesPath(), 'medicine.intakes')).readAsStringSync();
      final intakeHistory = IntakeHistory.deserialize(intakeString, settings.medications as List<Medicine>);
      final addedMeds = <Medicine, medicin.Medicine>{};
      for (final i in intakeHistory.getIntakes(DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(0),
        end: DateTime.now(),
      ))) {
        medicin.Medicine? med = addedMeds[i.medicine];
        if (med == null) {
          med = medicin.Medicine(
            designation: i.medicine.designation,
            color: i.medicine.color.value,
            dosis: i.medicine.defaultDosis == null ? null : Weight.mg(i.medicine.defaultDosis!),
          );
          addedMeds[i.medicine] = med;
          await medRepo.add(med);
        }
        final newI = MedicineIntake(
          time: i.timestamp,
          medicine: med,
          dosis: Weight.mg(i.dosis),
        );
        await intakeRepo.add(newI);
      }
    }

    File(join(await getDatabasesPath(), 'medicine.intakes')).deleteSync();
  } on PathNotFoundException {
    // pass
  } catch (e, stack) {
    await ErrorReporting.reportCriticalError('Error while migrating intakes to '
      'new format', '$e\n$stack',);
  }

  // Migrating records and notes
  try {
    final oldBpModel = await BloodPressureModel.create();
    for (final OldBloodPressureRecord r in await oldBpModel?.all ?? []) {
      if (r.diastolic != null || r.systolic != null || r.pulse != null) {
        await bpRepo.add(BloodPressureRecord(
          time: r.creationTime,
          sys: r.systolic == null ? null : Pressure.mmHg(r.systolic!),
          dia: r.diastolic == null ? null : Pressure.mmHg(r.diastolic!),
          pul: r.pulse,
        ));
      }
      if (r.notes.isNotEmpty || r.needlePin != null) {
        await noteRepo.add(Note(
          time: r.creationTime,
          note: r.notes.isEmpty ? null : r.notes,
          color: r.needlePin?.color.value,
        ));
      }
    }
    await oldBpModel?.close();
    File(join(await getDatabasesPath(), 'blood_pressure.db')).deleteSync();
  } on PathNotFoundException {
    // pass
  } catch (e, stack)  {
    await ErrorReporting.reportCriticalError('Error while migrating records to '
      'new format', '$e\n$stack',);
  }
}
