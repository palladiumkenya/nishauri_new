import 'package:flutter/cupertino.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/services/art_events_service.dart';

class ARTEventRepository {
  final ARTEventsService _service;

  ARTEventRepository(this._service);

  Future<List<ARTEvent>> getUserRelatedEvents() async {
    return await _service.getUserRelatedEvents();
  }


}
