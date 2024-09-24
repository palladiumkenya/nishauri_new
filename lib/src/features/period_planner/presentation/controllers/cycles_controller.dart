import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/repository/cycles_repository.dart';

class CyclesController extends StateNotifier<AsyncValue<Map<int, Cycle>>> {
  final CyclesRepository _repository;

  CyclesController(this._repository) : super(const AsyncValue.loading());

  Future<Map<int, Cycle>> fetchCycles() async {
    state = const AsyncValue.loading();
    try {
      final cycles = await _repository.fetchCycles();
      state = AsyncValue.data(cycles);
      return cycles;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return {};
    }
  }

  Future<void> postCycles(Cycle cycle) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.postCycles({
        'period_start': cycle.period_start.toIso8601String(),
        'period_end': cycle.period_end.toIso8601String(),
        'fertile_start': cycle.fertile_start.toIso8601String(),
        'fertile_end': cycle.fertile_end.toIso8601String(),
        'ovulation': cycle.ovulation.toIso8601String(),
        'predicted_period_start': cycle.predicted_period_start.toIso8601String(),
        'predicted_period_end': cycle.predicted_period_end.toIso8601String(),
        'cycle_length': cycle.cycle_length,
        'period_length': cycle.period_length,
      });
      await fetchCycles();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> editCycle(int cycleId, Cycle updatedCycle) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.putCycles(cycleId, {
        'period_start': updatedCycle.period_start.toIso8601String(),
        'period_end': updatedCycle.period_end.toIso8601String(),
        'fertile_start': updatedCycle.fertile_start.toIso8601String(),
        'fertile_end': updatedCycle.fertile_end.toIso8601String(),
        'ovulation': updatedCycle.ovulation.toIso8601String(),
        'predicted_period_start': updatedCycle.predicted_period_start.toIso8601String(),
        'predicted_period_end': updatedCycle.predicted_period_end.toIso8601String(),
        'cycle_length': updatedCycle.cycle_length,
        'period_length': updatedCycle.period_length,
      });
      await fetchCycles();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteCycle(int cycleId) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.deleteCycle(cycleId);
      await fetchCycles();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
