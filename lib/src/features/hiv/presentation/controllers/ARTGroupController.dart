import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_subscription.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';

class ARTGroupController extends StateNotifier<AsyncValue<List<ARTGroupSubscription>>> {
  final ARTGroupRepository _repository;

  ARTGroupController(this._repository) : super(const AsyncValue.data([])){
    _repository.getUserGroupSubscriptions().then((value) => state=AsyncValue.data(value));
  }

}
