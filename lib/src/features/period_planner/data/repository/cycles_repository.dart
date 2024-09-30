import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/services/cycles_service.dart';

class CyclesRepository {
  final CyclesService _service;

  CyclesRepository(this._service);

  Future<String> postCycles(Map<String, dynamic> data) async {
    return await _service.postCycles(data);
  }

  Future<Map<int, Cycle>> fetchCycles() async {
    return await _service.fetchCycles();
  }

  Future<String> putCycles(int cycleId, Map<String, dynamic> data) async{
    return await _service.putCycles(cycleId, data);
  }

  Future<String> deleteCycle(int cycleId) async {
    return await _service.deleteCycle(cycleId);
  }
}