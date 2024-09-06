import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cycle.dart';

final cyclesProvider = StateNotifierProvider<CyclesNotifier, List<Cycle>>((ref) {
  return CyclesNotifier();
});

class CyclesNotifier extends StateNotifier<List<Cycle>> {
  CyclesNotifier():super(cycles);

  void addCycle(Cycle newCycle) {
    state = [...state, newCycle];
  }

  void updatedCycle(String cycleId, Cycle updatedCycle) {
    state = [
      for (final cycle in state)
        if (cycle.cycleId == cycleId) updatedCycle else cycle
    ];
  }

  // void removeCycle(String cycleId) {
  //   state = state.where((cycle) => cycle.cycleId != cycleId).toList();
  // }
}