import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormDropDownInput.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppDropDownInput extends StatelessWidget {
  final List<DropdownMenuEntry<dynamic>> items;
  final String name;
  final String? label;
  final Function()? onPrefixIconPressed;
  final Function(String name, String value) onItemSelected;
  final IconData prefixIcon;
  final AppFormState formState;

  const AppDropDownInput({
    super.key,
    this.items = const [],
    required this.name,
    this.label,
    required this.prefixIcon,
    this.onPrefixIconPressed,
    required this.onItemSelected,
    required this.formState,
  });

  @override
  Widget build(BuildContext context) {
    return FormDropDownInput(
      error: formState.errors?[name],
      label: label,
      prefixIcon: prefixIcon,
      onPrefixIconPressed: onPrefixIconPressed,
      width: MediaQuery.of(context).size.width*0.75,
      onItemChange: (value)=>onItemSelected(name, value ?? ""),
      initialSelection: formState.values[name],
      dropdownMenuEntries: items,
      validator: (value) {
        List<String?>? errors =
        formState.validators?[name]?.map((fun) => fun(value)).where((element) => element != null).toList();
        return errors?.isNotEmpty==true ? errors?.join(", "): null;
      },
    );
  }
}
