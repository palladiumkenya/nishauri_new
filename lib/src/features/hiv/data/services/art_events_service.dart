import 'package:nishauri/src/features/hiv/data/models/address.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTEventsService extends HTTPService {
  String _token;
  final List<ARTEvent> _events = [
    const ARTEvent(
      title: "5th Annual Meeting",
      distributionTime: "20th Dec 2023 12:13 P.M",
      distributionLocation: Address(
          latitude: "-1.0986984",
          longitude: "36.9666969",
          address: "Ojijo road"),
      group: ARTGroup(title: "Title", lead: "Omosh"),
    ),
    const ARTEvent(
      title: "6th Annual Meeting",
      distributionTime: "20th Jan 2023 12:13 P.M",
      distributionLocation: Address(
          latitude: "-1.0986984",
          longitude: "36.9666969",
          address: "Ojijo road"),
      group: ARTGroup(title: "Title", lead: "Omosh"),
    ),
    const ARTEvent(
      title: "7th Annual Meeting",
      distributionTime: "20th Feb 2023 12:13 P.M",
      distributionLocation: Address(
          latitude: "-1.0986984",
          longitude: "36.9666969",
          address: "Ojijo road"),
      group: ARTGroup(title: "Title", lead: "Omosh"),
    ),
    const ARTEvent(
      title: "8th Annual Meeting",
      distributionTime: "20th Mar 2023 12:13 P.M",
      distributionLocation: Address(
          latitude: "-1.0986984",
          longitude: "36.9666969",
          address: "Ojijo road"),
      group: ARTGroup(title: "Title", lead: "Omosh"),
    ),
  ];

  ARTEventsService(this._token);

  Future<List<ARTEvent>> getUserRelatedEvents() async {
    await Future.delayed(const Duration(seconds: 3));
    return this._events;
  }
}
