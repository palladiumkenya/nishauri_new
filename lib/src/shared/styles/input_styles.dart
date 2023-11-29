import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

InputDecoration inputDecoration({
  double? borderRadius,
  required IconData prefixIcon,
  String? placeholder,
  String? label,
  final Function()? onPrefixIconPressed,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? Constants.ROUNDNESS),
      ),
    ),
    prefixIcon: IconButton(
      icon: Icon(prefixIcon),
      onPressed: onPrefixIconPressed,
    ),
    hintText: placeholder,
    label: label != null ? Text(label) : null,
  );
}
