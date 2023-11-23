import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppFormDateTimePicker extends StatelessWidget {
  final String name;
  final AppFormState formState;
  final void Function(String, String?) onDateChanged;
  final String format;
  final String? placeholder;
  final IconData prefixIcon;
  final Widget? surfixIcon;
  final String? label;
  final Function()? onPrefixIconPressed;
  final Function()? onsurfixIconPressed;

  const AppFormDateTimePicker(
      {super.key,
      required this.name,
      required this.formState,
      this.format = "dd MMM yyyy",
      required this.onDateChanged,
      this.onsurfixIconPressed,
      this.onPrefixIconPressed,
      this.label,
      this.placeholder,
      required this.prefixIcon,
      this.surfixIcon});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateCtl = TextEditingController(
        text: formState.values[name] != null
            ? DateFormat(format).format(
                DateTime.parse(
                  formState.values[name],
                ),
              )
            : null);
    return FormInputTextField(
      controler: dateCtl,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          onDateChanged(name, pickedDate.toIso8601String());
        } else {}
      },
      placeholder: placeholder,
      prefixIcon: prefixIcon,
      label: label,
      onPrefixIconPressed: onPrefixIconPressed,
      onsurfixIconPressed: onsurfixIconPressed,
      error: formState.errors?[name],
      validator: (value) {
        List<String?>? errors = formState.validators?[name]
            ?.map((fun) => fun(value))
            .where((element) => element != null)
            .toList();
        return errors?.join(", ");
      },
    );
  }
}
