import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppFormStateNotifier extends StateNotifier<AppFormState> {
  AppFormStateNotifier(Map<String, dynamic> initialValues)
      : super(AppFormState(values: initialValues));

  void setFieldValue(String field, dynamic value) {
    if (isValidField(field)) {
      final values = state.values;
      values.addAll({field: value});
      state = state.copyWith(values: values);
    }
  }

  void setFieldError(String field, String error) {
    if (isValidField(field)) {
      var errors = state.errors;
      if (errors == null) {
        errors = {field: error};
      } else {
        errors[field] = error;
      }
      state = state.copyWith(errors: errors);
    }
  }

  void addFieldValidator(String field, FormFieldValidator validator) {
    if (isValidField(field)) {
      Map<String, List<FormFieldValidator>>? validators = state.validators;
      if (validators == null) {
        validators = {
          field: [validator]
        };
      } else {
        var fieldValidators = validators[field];
        if (fieldValidators != null) {
          fieldValidators.add(validator);
          validators[field] = fieldValidators;
        } else {
          // If the field doesn't exist in validators, create a new entry
          validators[field] = [validator];
        }
      }
      state = state.copyWith(validators: validators);
    }
  }

  void addFieldValidators(String field, List<FormFieldValidator> validators) {
    if (isValidField(field)) {
      for (var validator in validators) {
        addFieldValidator(field, validator);
      }
    }
  }

  void clearFieldValidators(String field) {
    if (isValidField(field)) {
      Map<String, List<FormFieldValidator>>? validators = state.validators;
      if (validators != null && validators.containsKey(field)) {
        // Reset the validators for the specified field to an empty array
        validators[field] = [];
        state = state.copyWith(validators: validators);
      }
    }
  }

  bool isValidField(String field) => state.values.containsKey(field);
}
