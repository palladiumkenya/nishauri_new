import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/repository/blood_sugar_repository.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/services/blood_sugar_service.dart';

final bloodSugarProvider = Provider<BloodSugarRepository>((ref) {
  return BloodSugarRepository(BloodSugarService());
});

final bloodSugarEntriesProvider = FutureProvider<List<BloodSugar>>((ref) async {
  final repository = ref.watch(bloodSugarProvider);
  return await repository.getBloodSugars();
});
