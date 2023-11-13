import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppFormStateNotifier extends StateNotifier<AppFormState> {
  AppFormStateNotifier({
    required Map<String, dynamic> initialValues,
    Map<String, List<String? Function(String?)>>? validators,
  }) : super(AppFormState(values: initialValues, validators: validators));

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

  void addFieldValidator(String field, String? Function(String?) validator) {
    if (isValidField(field)) {
      Map<String, List<String? Function(String?)>>? validators =
          state.validators;
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

  void addFieldValidators(
      String field, List<String? Function(String?)> validators) {
    if (isValidField(field)) {
      for (var validator in validators) {
        addFieldValidator(field, validator);
      }
    }
  }

  void clearFieldValidators(String field) {
    if (isValidField(field)) {
      Map<String, List<String? Function(String?)>>? validators =
          state.validators;
      if (validators != null && validators.containsKey(field)) {
        // Reset the validators for the specified field to an empty array
        validators[field] = [];
        state = state.copyWith(validators: validators);
      }
    }
  }

  bool isValidField(String field) => state.values.containsKey(field);

  void validateField(String field) {
    debugPrint("****************| VALIDATING FIELD |*********************");
    if (isValidField(field)) {
      final validators = state.validators;
      if (validators != null) {
        var fieldValidators = validators[field];
        if (fieldValidators != null) {
          for (var validate in fieldValidators) {
            final error = validate(state.values[field]);
            if (error != null) {
              setFieldError(field, error);
              return;
            }
          }
        }
      }
    }
  }

  void clearFieldError(String field){
    if(state.errors?.containsKey(field)==true){
      final errors = state.errors;
      errors!.removeWhere((key, _) => key == field);
    }
  }
}
