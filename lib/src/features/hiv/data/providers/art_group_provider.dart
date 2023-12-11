import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/models.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_groups_service.dart';
import 'package:nishauri/src/features/hiv/presentation/controllers/ARTGroupController.dart';

final art_group_provider =
    StateNotifierProvider<ARTGroupController, AsyncValue<List<ARTGroupSubscription>>>(
        (ref) {
  // Retrieve the authentication token from the authStateProvider
  final authState = ref.watch(authStateProvider);
  final service = ARTGroupService(authState);
  final repository = ARTGroupRepository(service);
  return ARTGroupController(repository);
});
