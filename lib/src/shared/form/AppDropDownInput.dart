import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppDropDownInputItem {
  final String value;
  final String label;

  AppDropDownInputItem({required this.value, required this.label});
}

class AppDropDownInput extends StatelessWidget {
  final List<AppDropDownInputItem> items;
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
    return DropdownMenu<String>(
      label: label != null ? Text(label!) : null,
      leadingIcon: IconButton(
        onPressed: onPrefixIconPressed,
        icon: Icon(prefixIcon),
      ),
      width: MediaQuery.of(context).size.width*0.75,
      onSelected: (value)=>onItemSelected(name, value ?? ""),
      initialSelection: formState.values[name],
      dropdownMenuEntries: items
          .map<DropdownMenuEntry<String>>(
            (AppDropDownInputItem item) => DropdownMenuEntry<String>(
              value: item.value,
              label: item.label,

            ),
          )
          .toList(),
    );
  }
}
