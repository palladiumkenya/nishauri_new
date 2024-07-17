import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:nishauri/src/features/bmi/data/repositories/bmi_log_repository.dart';

class BMILogController extends StateNotifier<AsyncValue<String>> {
  final BMILogRepository _repository;

  BMILogController(this._repository)
    : super(const AsyncValue.data(''));

  Future<void> logBMI(double height, double weight, double bmi) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.logBMI({
        'height': height,
        'weight': weight,
        'bmi': bmi,
      });
      state = AsyncValue.data(response);
    }
    catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }   

}