import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/repositories/shortcut_repository.dart';
import 'package:nishauri/src/features/common/presentation/controllers/shortcut_controller.dart';

final shortcutProvider = StateNotifierProvider<ShortcutController, List<String>>((ref) {
  final repository = ShortcutRepository();
  return ShortcutController(repository);
});