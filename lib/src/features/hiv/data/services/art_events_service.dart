import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTEventsService extends HTTPService {
  final List<ARTEvent> _events = [
    const ARTEvent(
      id: "e-1",
      title: "5th Annual Meeting",
      distributionTime: "2023-03-06",
      venue: "Kigali rwanda church",
      group: ARTGroup(title: "Cambrigia lipora", lead: "Omosh"),
      reminderNotificationDates: ["2023-03-06", "2023-03-06"]
    ),
    const ARTEvent(
      id: "e-2",
      title: "6th Annual Meeting",
      distributionTime: "2023-03-06",
      venue:"Kaduda Plaza",
      group: ARTGroup(title: "Mbaroga Chilom center", lead: "Omosh"),
      reminderNotificationDates: ["2023-03-06"]
    ),
    const ARTEvent(
      id: "e-3",
      title: "7th Annual Meeting",
      distributionTime: "2023-03-06",
      venue: "Sarova Beech",
      group: ARTGroup(title: "Gara Refereal", lead: "Omosh"),
    ),
    const ARTEvent(
      id: "e-4",
      title: "8th Annual Meeting",
      distributionTime: "2023-03-06",
      venue: "Makena Cattle deep",
      group: ARTGroup(title: "Kamomo ART Group", lead: "Omosh"),
    ),
  ];

  Future<List<ARTEvent>> getUserRelatedEvents() async {
    await Future.delayed(const Duration(seconds: 3));
    return this._events;
  }
}
