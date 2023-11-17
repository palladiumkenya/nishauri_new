import 'package:nishauri/src/features/hiv/data/models/regimen/art_regimen.dart';
import 'package:nishauri/src/features/hiv/data/services/art_regimen_service.dart';

class ARTRegimenRepository {
  final ARTRegimenService _service;

  ARTRegimenRepository(this._service);

  Future<List<ARTRegimen>> getUserRegimenHistory() async {
    return await _service.getARTRegimenHistory();
  }
}
