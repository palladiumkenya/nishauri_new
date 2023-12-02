import 'package:nishauri/src/features/hiv/data/models/models.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTGroupService extends HTTPService {
  final String _token;
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
        id: "s-1",
        group: ARTGroup(
          title: "Marathon group ",
          lead: "l-1",
          id: "g-1",
          description: "Some group description",
        ),
        patient: "u-1",
        name: "Omosh",
        createdAt: "25th Oct 2023",
        isCurrent: true),
    const ARTGroupSubscription(
        id: "s-2",
        group: ARTGroup(
          title: "Jambo group ",
          lead: "l-2",
          id: "g-2",
          description: "Some group description",
        ),
        patient: "u-1",
        createdAt: "25th Oct 2023",
        name: "Omoshi"),
    const ARTGroupSubscription(
        id: "s-3",
        group: ARTGroup(
          title: "Kabogo group ",
          lead: "l-3",
          id: "g-3",
          description: "Some group description",
        ),
        patient: "u-1",
        createdAt: "25th Oct 2023",
        name: "Lawi"),
    const ARTGroupSubscription(
        id: "s-4",
        group: ARTGroup(
          title: "Oyula group ",
          lead: "l-4",
          id: "g-4",
          description: "Some group description",
        ),
        createdAt: "25th Oct 2023",
        patient: "u-1",
        name: "<Omosh/>"),
  ];
  final List<ARTGroupLead> _leads = [
    const ARTGroupLead(group: "g-1", user: "u-1"),
    const ARTGroupLead(group: "g-2", user: "u-2"),
    const ARTGroupLead(group: "g-3", user: "u-3"),
    const ARTGroupLead(group: "g-4", user: "u-4"),
  ];

  ARTGroupService(this._token);

  Future<List<ARTGroup>> getUserARTGroups() async {
    return _groups;
  }

  Future<ARTGroupSubscription> addARTGroup(ARTGroup group) async {
    // throw ValidationException({"title": "Group with title already exist", "description": "Description is too long"});
    _groups.add(group);
    final subscription = ARTGroupSubscription(
      id: "s-${_subscriptions.length}-1",
      group: group,
      patient: "patient",
      createdAt: DateTime.now().toIso8601String(),
    );
    _subscriptions.add(subscription);
    return subscription;
  }

  Future<List<ARTGroupSubscription>> getUserSubscriptions() async {
    await Future.delayed(const Duration(seconds: 3));
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
