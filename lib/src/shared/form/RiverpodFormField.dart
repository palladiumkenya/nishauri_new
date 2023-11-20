import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/shared/states/AppFormStateNotifier.dart';

class RiverpodFormField extends ConsumerWidget {
  final String name;
  final bool? password;
  final Function()? onPrefixIconPressed;
  final Function()? onsurfixIconPressed;
  final IconData prefixIcon;
  final Widget? surfixIcon;
  final String? placeholder;
  final String label;
  final TextInputType? keyboardType;
  final StateNotifierProvider<AppFormStateNotifier, AppFormState>
      provider;

  const RiverpodFormField(
      {super.key,
      required this.name,
      this.password,
      required this.prefixIcon,
      this.onsurfixIconPressed,
      this.surfixIcon,
      this.onPrefixIconPressed,
      required this.label,
      this.placeholder,
      this.keyboardType,
      required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final stateSetter = ref.watch(provider.notifier);
    return FormInputTextField(
      error: state.errors != null ? state.errors![name] : null,
      prefixIcon: prefixIcon,
      label: label,
      placeholder: placeholder,
      password: password ?? false,
      initialValue: state.values[name],
      onChangeText: (value){
          stateSetter.setFieldValue(name, value);
          stateSetter.validateField(name);
      }
    );
  }
}
