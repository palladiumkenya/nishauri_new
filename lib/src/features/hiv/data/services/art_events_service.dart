import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTEventsService extends HTTPService {
  final List<ARTEvent> _events = [

  ];

  Future<List<ARTEvent>> getUserRelatedEvents() async {
    await Future.delayed(const Duration(seconds: 3));
    return this._events;
  }
}
