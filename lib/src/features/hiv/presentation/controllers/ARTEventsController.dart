import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_events_repository.dart';

class ARTEventController extends StateNotifier<AsyncValue<List<ARTEvent>>> {
  final ARTEventRepository _repository;

  ARTEventController(this._repository) : super(const AsyncValue.loading()) {
    getUserEvents();
  }

  Future<void> getUserEvents()async{
    state = const AsyncValue.loading();
    try{
      final events = await _repository.getUserRelatedEvents();
      state = AsyncValue.data(events);
    }catch(e){
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  Future<void> addEvent(Map<String, dynamic> data)async{

  }
}
