import 'package:flutter/material.dart';

class AppFormState {
  Map<String, dynamic> values;
  Map<String, String?>? errors;
  Map<String, List<String? Function(String?)>>? validators;

  AppFormState({required this.values, this.errors, this.validators});

  AppFormState copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    Map<String, List<String? Function(String?)>>? validators,
  }) =>
      AppFormState(
        values: values ?? this.values,
        errors: errors ?? this.errors,
        validators: validators ?? this.validators,
      );

  @override
  String toString() {
    return "{values: ${values}, errors: $errors, validators: $validators }";
  }
}
