import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppFormTextInput extends StatelessWidget {
  final bool password;
  final Function()? onPrefixIconPressed;
  final Function()? onsurfixIconPressed;
  final Function(String name, String value) onChangeText;
  final IconData prefixIcon;
  final Widget? surfixIcon;
  final String? placeholder;
  final String? label;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final bool readOnly;
  final Function()? onTap;
  final void Function(String?)? onSaved;
  final String name;
  final AppFormState formState;

  const AppFormTextInput({
    super.key,
    this.password = false,
    required this.prefixIcon,
    this.placeholder,
    this.label,
    this.onPrefixIconPressed,
    this.onsurfixIconPressed,
    this.surfixIcon,
    required this.onChangeText,
    this.borderRadius,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.onSaved,
    required this.name,
    required this.formState,
  });

  @override
  Widget build(BuildContext context) {
    return FormInputTextField(
      initialValue: formState.values[name],
      error: formState.errors?[name],
      onChangeText: (value) => onChangeText(name, value),
      validator: (value) {
        List<String?>? errors =
            formState.validators?[name]?.map((fun) => fun(value)).where((element) => element != null).toList();
        return errors?.isNotEmpty==true ? errors?.join(", "): null;
      },
      prefixIcon: prefixIcon,
      password: password,
      onTap: onTap,
      onSaved: onSaved,
      onPrefixIconPressed: onPrefixIconPressed,
      onsurfixIconPressed: onsurfixIconPressed,
      placeholder: placeholder,
      label: label,
      surfixIcon: surfixIcon,
      borderRadius: borderRadius,
      keyboardType: keyboardType,
      readOnly: readOnly,
    );
  }
}
