import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/visits/data/models/visit.dart';
import 'package:nishauri/src/features/visits/data/repositories/visits_repository.dart';
import 'package:nishauri/src/features/visits/data/services/visits_service.dart';

final visitProvider = FutureProvider<List<Visit>>((ref) async {
  final authState = ref.watch(authStateProvider);
  VisitService service = VisitService(authState);
  VisitsRepository repository = VisitsRepository(service);
  return await repository.getVisits();
});
