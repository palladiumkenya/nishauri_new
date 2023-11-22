import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/repositories/shortcut_repository.dart';

class ShortcutController extends StateNotifier<List<String>> {
  final ShortcutRepository _repository;

  ShortcutController(this._repository) : super([]) {
    _repository.getShortcuts().then((value) => state = value);
  }

  Future<void> addShortcut(String menu) async {
    state = [...state, menu];
  }
  Future<void> deleteShortcut(String menu) async {
    state = state.where((element) => element != menu).toList();
  }
}
