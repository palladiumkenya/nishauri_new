

import 'package:nishauri/src/features/bp/data/data_store/repositories/repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/blood_pressure_record.dart';

/// Repository for [BloodPressureRecord]s.
/// 
/// Provides high level access on [BloodPressureRecord]s saved in a 
/// [DatabaseManager] managed database. Allows to store and query records.
abstract class BloodPressureRepository extends Repository<BloodPressureRecord>{}
