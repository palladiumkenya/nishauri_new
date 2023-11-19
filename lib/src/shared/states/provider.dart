import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'AppFormState.dart';
import 'AppFormStateNotifier.dart';

final formStateProvider = StateNotifierProvider<
    AppFormStateNotifier,
    AppFormState>((ref) =>AppFormStateNotifier(initialValues: {}));