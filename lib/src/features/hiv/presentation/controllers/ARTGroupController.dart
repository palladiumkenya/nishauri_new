import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_subscription.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';

class ARTGroupController
    extends StateNotifier<AsyncValue<List<ARTGroupSubscription>>> {
  final ARTGroupRepository _repository;

  ARTGroupController(this._repository) : super(const AsyncValue.data([])) {
    getUserGroupSubscriptions();
  }

  Future<void> getUserGroupSubscriptions() async {
    state = const AsyncValue.loading();
    try {
      final userSubscriptions = await _repository.getUserGroupSubscriptions();
      state = AsyncValue.data(userSubscriptions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addARTGroup(Map<String, dynamic> data) async {
    try {
      await _repository.addGroup(data);
      await getUserGroupSubscriptions();
    } catch (e) {
      rethrow;
    }
  }
  Future<void> updateARTGroup(Map<String, dynamic> data) async {
    try {
      await _repository.updateGroup(data);
      await getUserGroupSubscriptions();
    } catch (e) {
      rethrow;
    }
  }
}
