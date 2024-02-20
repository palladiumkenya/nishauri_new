import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/art_treatment_support/art_treatment_support.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_treatment_support_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_treatment_support_service.dart';

final artTreatmentSupportProvider =
    FutureProvider<List<ARTTreatmentSupport>>((ref) async {
  final repo = ARTTreatmentSupportRepository(ARTTreatmentSupportService());
  return await repo.getTreatmentSupport();
});
