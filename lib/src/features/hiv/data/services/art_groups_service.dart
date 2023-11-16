import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_lead.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_subscription.dart';

class ARTGroupService {
  String token;
  final List<ARTGroup> _groups = [
    const ARTGroup(
      title: "Marathon group ",
      lead: "l-1",
      id: "g-1",
      description: "Some group description",
    ),
    const ARTGroup(
      title: "Jambo group ",
      lead: "l-2",
      id: "g-2",
      description: "Some group description",
    ),
    const ARTGroup(
      title: "Kabogo group ",
      lead: "l-3",
      id: "g-3",
      description: "Some group description",
    ),
    const ARTGroup(
      title: "Oyula group ",
      lead: "l-4",
      id: "g-4",
      description: "Some group description",
    ),
  ];
  final List<ARTGroupSubscription> _subscriptions = [
    const ARTGroupSubscription(
        group: "g-1", patient: "u-1", name: "Omosh", isCurrent: true),
    const ARTGroupSubscription(group: "g-2", patient: "u-1", name: "Omoshi"),
    const ARTGroupSubscription(group: "g-3", patient: "u-1", name: "Lawi"),
    const ARTGroupSubscription(group: "g-4", patient: "u-1", name: "<Omosh/>"),
  ];
  final List<ARTGroupLead> _leads = [
    const ARTGroupLead(group: "g-1", user: "u-1"),
    const ARTGroupLead(group: "g-2", user: "u-2"),
    const ARTGroupLead(group: "g-3", user: "u-3"),
    const ARTGroupLead(group: "g-4", user: "u-4"),
  ];

  ARTGroupService(this.token);

  Future<List<ARTGroup>> getUserARTGroups() async {
    return _groups;
  }

  Future<ARTGroup> addARTGroup(ARTGroup group) async {
    _groups.add(group);
    return group;
  }

  Future<List<ARTGroupSubscription>> getUserSubscriptions() async {
    return _subscriptions;
  }

  Future<List<ARTGroupLead>> getLeadsByGroupId(String id) async {
    return _leads.where((element) => element.group == id).toList();
  }

  Future<ARTGroupSubscription> getSubscriptionById(String id) async {
    return _subscriptions.firstWhere((element) => element.id == id);
  }

  Future<ARTGroupLead> getGroupLeadById(String id) async {
    return _leads.firstWhere((element) => element.id == id);
  }
}
