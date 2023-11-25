import 'package:flutter/material.dart';

class AppFormState {
  Map<String, dynamic> values;
  Map<String, String?>? errors;
  Map<String, List<String? Function(String?)>>? validators;
  bool submitting;

  AppFormState({required this.values, this.errors, this.validators, this.submitting=false});

  AppFormState copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    Map<String, List<String? Function(String?)>>? validators,
    bool? submitting
  }) =>
      AppFormState(
        values: values ?? this.values,
        errors: errors ?? this.errors,
        validators: validators ?? this.validators,
        submitting: submitting ?? this.submitting
      );

  @override
  String toString() {
    return "{values: ${values}, errors: $errors, validators: $validators }";
  }
}
