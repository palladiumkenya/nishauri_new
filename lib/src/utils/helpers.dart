import 'package:flutter/material.dart';

double getInputFieldHeight(BuildContext context) {
  ThemeData theme = Theme.of(context);

  // Access the contentPadding from the InputDecoration
  EdgeInsetsGeometry? inputFieldPadding =
      theme.inputDecorationTheme.contentPadding;

// Get the height of the input field
  double inputFieldHeight = inputFieldPadding?.vertical ?? 100;

  return inputFieldHeight;
}
