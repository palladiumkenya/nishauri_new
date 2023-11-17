import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_events_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_events_service.dart';
import 'package:nishauri/src/features/hiv/presentation/controllers/ARTEventsController.dart';

final art_event_provider =
    StateNotifierProvider<ARTEventController, AsyncValue<List<ARTEvent>>>(
        (ref) {
  // Retrieve the authentication token from the authStateProvider
  final String token = ref.watch(authStateProvider);
  final service = ARTEventsService(token);
  final repository = ARTEventRepository(service);
  return ARTEventController(repository);
});
