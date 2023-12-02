import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_events_repository.dart';

class ARTEventController extends StateNotifier<AsyncValue<List<ARTEvent>>> {
  final ARTEventRepository _repository;

  ARTEventController(this._repository) : super(const AsyncValue.loading()) {
    _repository
        .getUserRelatedEvents()
        .then((value) => state = AsyncValue.data(value));
  }
}
