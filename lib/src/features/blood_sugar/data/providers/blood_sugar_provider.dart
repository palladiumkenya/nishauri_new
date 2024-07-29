import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/blood_sugar/data/repository/blood_sugar_repository.dart';

class BloodSugarNotifier extends StateNotifier<List<BloodSugar>> {
  final BloodSugarRepository repository;

  BloodSugarNotifier(this.repository) : super(repository.getAllEntries());

  void addEntry(BloodSugar entry) {
    repository.addEntry(entry);
    state = [...state, entry];
  }

  void refreshEntries() {
    state = repository.getAllEntries();
  }
}

final bloodSugarProvider = Provider<BloodSugarRepository>((ref) {
  return BloodSugarRepository();
});

final bloodSugarEntriesProvider =
    StateNotifierProvider<BloodSugarNotifier, List<BloodSugar>>((ref) {
  final repository = ref.watch(bloodSugarProvider);
  return BloodSugarNotifier(repository);
});
