import 'package:nishauri/src/features/visits/data/models/visit.dart';
import 'package:nishauri/src/features/visits/data/services/visits_service.dart';

class VisitsRepository {
  final VisitService _service;

  VisitsRepository(this._service);

  Future<List<Visit>> getVisits() async {
    final visits = await _service.getVisits();
    return visits;
  }
}
