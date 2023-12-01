import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_subscription.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';

class ARTGroupController
    extends StateNotifier<AsyncValue<List<ARTGroupSubscription>>> {
  final ARTGroupRepository _repository;

  ARTGroupController(this._repository) : super(const AsyncValue.data([])) {
    getUserPrograms();
  }

  Future<void> getUserPrograms() async {
    state = const AsyncValue.loading();
    try {
      final userSubscriptions = await _repository.getUserGroupSubscriptions();
      state = AsyncValue.data(userSubscriptions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
