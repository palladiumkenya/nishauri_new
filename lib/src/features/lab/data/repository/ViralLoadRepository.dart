
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/features/lab/data/services/ViralLoadService.dart';

class ViralLoadRepository {
  final ViralLoadService _service;

  ViralLoadRepository(this._service);

  Future<List<ViralLoad>> getViralLoads() async {
    final viralLoads = await _service.getViralLoads();
    return viralLoads;
  }

  Future<void> saveViralLoad() async {
    await _service.saveViralLoad();
  }
}
