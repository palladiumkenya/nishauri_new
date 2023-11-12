import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/shared/states/AppFormStateNotifier.dart';

class AppForm extends StatelessWidget {
  final StateNotifierProvider<AppFormStateNotifier, AppFormState> provider;
  final Map<String, dynamic> initialValues;
  final Widget child;

  const AppForm(
      {super.key,
      required this.provider,
      required this.child,
      required this.initialValues});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        // Override the default provider with a new provider
        provider.overrideWith(
          (ref) => AppFormStateNotifier(initialValues),
        ),
      ],
      child: child,
    );
  }
}
