import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';

class BloodSugarRepository {
  final List<BloodSugar> _entries = [];

  List<BloodSugar> getAllEntries() {
    return _entries;
  }

  void addEntry(BloodSugar entry) {
    print("Adding entry repository: $entry");
    _entries.add(entry);
  }
}
