import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';

final idleTimeoutProvider = StateNotifierProvider<IdleTimeoutNotifier, int>((ref) {
  return IdleTimeoutNotifier(ref);
});

class IdleTimeoutNotifier extends StateNotifier<int> {
  IdleTimeoutNotifier(this.ref) : super(0) {
    _startTimer();
  }

  final Ref ref;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 5), _logoutUser);
  }

  void _logoutUser() {
    // Implement your logout logic here
    // For example, you might navigate to the login screen or clear user data
    ref.read(authStateProvider.notifier).logout();
    print("User logged out due to inactivity");
  }

  void resetTimer() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
