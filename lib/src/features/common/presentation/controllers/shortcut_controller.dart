import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/repositories/shortcut_repository.dart';

class ShortcutController extends StateNotifier<List<String>> {
  final ShortcutRepository _repository;
  final int _maxShortcuts = 4;

  int get maxShortcuts => _maxShortcuts;

  ShortcutController(this._repository) : super([]) {
    _repository.getShortcuts().then((value) => state = value);
  }

  Future<void> addShortcut(String menu) async {
    if (state.length < maxShortcuts) {
      state = [...state, menu];
      await _repository.save(state);
    }
  }

  Future<void> deleteShortcut(String menu) async {
    state = state.where((element) => element != menu).toList();
    await _repository.save(state);
  }
}
