import 'package:nishauri/src/features/hiv/data/services/art_treatment_support_service.dart';

import '../models/art_treatment_support/art_treatment_support.dart';

class ARTTreatmentSupportRepository {
  final ARTTreatmentSupportService _service;
  const ARTTreatmentSupportRepository(this._service);


  Future<List<ARTTreatmentSupport>> getTreatmentSupport() async {
    return _service.getTreatmentSupport();
  }

}