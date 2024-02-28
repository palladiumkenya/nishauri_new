import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_subscription.dart';
import 'package:nishauri/src/features/hiv/data/services/art_groups_service.dart';

class ARTGroupRepository {
  final ARTGroupService _service;

  ARTGroupRepository(this._service);

  Future<List<ARTGroupSubscription>> getUserGroupSubscriptions() async {
    return await _service.getUserSubscriptions();
  }

  Future<List<ARTGroup>> getUserGroups() async {
    return await _service.getUserARTGroups();
  }

  Future<void> addGroup(Map<String, dynamic> group) async {
    return await _service.addARTGroup(group);
  }

  Future<void> updateGroup(Map<String, dynamic> group)async {
    return await _service.addARTGroup(group);
  }
}
