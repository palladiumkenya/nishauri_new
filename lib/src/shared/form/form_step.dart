import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class FormState extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;
  const FormState({super.key, required this.formState, required this.onFormFieldChanged});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
