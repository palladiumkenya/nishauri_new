import 'package:nishauri/src/features/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/features/bp/data/services/blood_pressure_service.dart';

class BloodPressureRepository {
  final BloodPressureService _service;

  BloodPressureRepository(this._service);

  Future<String> saveBloodPressure (BloodPressure data) async {
    return await _service.saveBloodPressure(data);
  }

  Future<List<BloodPressure>> getBloodPressures() async {
    return await _service.fetchBloodPressures();
  }
}