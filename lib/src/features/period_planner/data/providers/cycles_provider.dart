import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/period_planner/data/repository/cycles_repository.dart';
import 'package:nishauri/src/features/period_planner/data/services/cycles_service.dart';
import 'package:nishauri/src/features/period_planner/presentation/controllers/cycles_controller.dart';
import '../models/cycle.dart';

final cyclesProvider = StateNotifierProvider<CyclesController, AsyncValue<Map<int, Cycle>>> ((ref) {
  final service = CyclesService();
  final repository = CyclesRepository(service);
  return CyclesController(repository);
});

// final cyclesRepositoryProvider = Provider<CyclesRepository>((ref) {
//   return CyclesRepository(CyclesService());
// });

// final cyclesListProvider = FutureProvider<List<Cycle>>((ref) async {
//   final repository = ref.watch(cyclesRepositoryProvider);
//   return await repository.fetchCycles();
// });

// final cyclesProvider = StateNotifierProvider<CyclesNotifier, List<Cycle>>((ref) {
//   return CyclesNotifier();
// });

// class CyclesNotifier extends StateNotifier<List<Cycle>> {
//   CyclesNotifier():super(cycles);

//   void addCycle(Cycle newCycle) {
//     state = [...state, newCycle];
//   }

//   void updatedCycle(String cycleId, Cycle updatedCycle) {
//     state = [
//       for (final cycle in state)
//         if (cycle.cycleId == cycleId) updatedCycle else cycle
//     ];
//   }

//   // void removeCycle(String cycleId) {
//   //   state = state.where((cycle) => cycle.cycleId != cycleId).toList();
//   // }
// }