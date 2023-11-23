import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';

class AppFormImagePicker extends StatelessWidget {
  final AppFormState formState;
  final String name;
  final Function(String name, String? value) onImageChange;

  const AppFormImagePicker(
      {super.key,
      required this.formState,
      required this.onImageChange,
      required this.name
      });

  @override
  Widget build(BuildContext context) {
    return ImagePickerCustomFormField(
      image: formState.values[name],
      onImageChange: (image) => onImageChange(name, image),
      error: formState.errors?[name],
      validator: (value) {
        List<String?>? errors =
        formState.validators?[name]?.map((fun) => fun(value)).where((element) => element != null).toList();
        return errors?.join(", ");
      },
    );
  }
}
