import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_groups_service.dart';
import 'package:nishauri/src/features/hiv/presentation/controllers/ARTGroupController.dart';

final art_group_provider =
    StateNotifierProvider<ARTGroupController, AsyncValue<List<ARTGroup>>>(
        (ref) {
  // Retrieve the authentication token from the authStateProvider
  // await Future.delayed(const Duration(seconds: 5));
  final String token = ref.watch(authStateProvider);

  final service = ARTGroupService(token);
  final repository = ARTGroupRepository(service);
  return ARTGroupController(repository);
});
