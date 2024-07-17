import 'package:nishauri/src/features/bmi/data/services/bmi_log_service.dart';

class BMILogRepository {
  final BMILogService _service;

  BMILogRepository(this._service);

  Future<String> logBMI(Map<String, dynamic> data) async {
    return await _service.logBMI(data);
  }
}