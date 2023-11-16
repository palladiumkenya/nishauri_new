import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_groups_repository.dart';

class ARTGroupController extends StateNotifier<AsyncValue<List<ARTGroup>>> {
  final ARTGroupRepository _repository;

  ARTGroupController(this._repository) : super(const AsyncValue.data([]));

  Future<void> addARTGroup({
    String? id,
    required String title,
    String? description,
    required String lead,
  }) async {
    final group =
        ARTGroup(title: title, lead: lead, description: description, id: id);
    await _repository.addGroup(group);
    state.whenData((value) {
      state = AsyncValue.data([...value, group]);
    });
  }
}
