import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class FormInputTextField extends StatefulWidget {
  final bool password;
  final String? Function(String? value)? validator;
  final Function()? onPrefixIconPressed;
  final Function()? onsurfixIconPressed;
  final Function(String value)? onChangeText;
  final IconData prefixIcon;
  final Widget? surfixIcon;
  final String? placeholder;
  final String label;
  final TextEditingController? controler;
  final TextInputType? keyboardType;
  final double? borderRadius;

  const FormInputTextField({
    super.key,
    this.password = false,
    this.validator,
    required this.prefixIcon,
    this.placeholder,
    required this.label,
    this.controler,
    this.onPrefixIconPressed,
    this.onsurfixIconPressed,
    this.surfixIcon,
    this.onChangeText,
    this.borderRadius, this.keyboardType,
  });

  @override
  State<FormInputTextField> createState() => _FormInputTextFieldState();
}

class _FormInputTextFieldState extends State<FormInputTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controler,
      validator: widget.validator,
      obscureText: widget.password && showPassword == false,
      onChanged: widget.onChangeText,
      decoration: InputDecoration(
        suffixIcon: widget.password
            ? IconButton(
                icon: Icon(showPassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword; // Toggle the value
                  });
                },
              )
            : widget.surfixIcon != null
                ? IconButton(
                    onPressed: widget.onsurfixIconPressed,
                    icon: widget.surfixIcon!)
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius ?? Constants.ROUNDNESS),
          ),
        ),
        prefixIcon: IconButton(
          icon: Icon(widget.prefixIcon),
          onPressed: widget.onPrefixIconPressed,
        ),
        hintText: widget.placeholder,
        label: Text(widget.label),
      ),
    );
  }
}
