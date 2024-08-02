import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/blood_sugar/data/services/blood_sugar_service.dart';

class BloodSugarRepository {
  final BloodSugarService _service;

  BloodSugarRepository(this._service);

  Future<String> saveBloodSugar(BloodSugar data) async {
    return await _service.saveBloodSugar(data);
  }

  Future<List<BloodSugar>> getBloodSugars() async {
    return await _service.fetchBloodSugars();
  }
}
