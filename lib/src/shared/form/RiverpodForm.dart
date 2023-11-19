import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/shared/states/AppFormStateNotifier.dart';

class RiverpodForm extends StatelessWidget {
  final Widget Function(
      BuildContext context,
      StateNotifierProvider<AppFormStateNotifier, AppFormState>
          formStateProvider) builder;
  final Map<String, dynamic> initialValues;

  const RiverpodForm(
      {Key? key, required this.initialValues, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formStateProvider =
        StateNotifierProvider<AppFormStateNotifier, AppFormState>(
            (ref) => AppFormStateNotifier(initialValues: initialValues));
    return ProviderScope(
      overrides: [
        formStateProvider.overrideWith(
            (ref) => AppFormStateNotifier(initialValues: initialValues))
      ],
      child: builder(context, formStateProvider),
    );
  }
}
