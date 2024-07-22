import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/features/bp/data/repository/blood_pressure_repository.dart';
import 'package:nishauri/src/features/bp/data/services/blood_pressure_service.dart';

final bloodPressureRepositoryProvider = Provider<BloodPressureRepository>((ref) {
  return BloodPressureRepository(BloodPressureService());
});

final bloodPressureListProvider = FutureProvider<List<BloodPressure>>((ref) async {
  final repository = ref.watch(bloodPressureRepositoryProvider);
  return await repository.getBloodPressures();
});