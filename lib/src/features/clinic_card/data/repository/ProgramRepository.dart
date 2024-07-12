import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/features/clinic_card/data/services/ProgramService.dart';

class ProgramRepository {
  final ProgramService _service;

  ProgramRepository(this._service);

  Future<List<Program>> getPrograms() async {
    final programs = await _service.getPrograms();
    return programs;
  }

  Future<void> saveRegimen() async {
    await _service.saveRegimen();
  }
}
