import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/presentation/components/input_dialoge.dart';

class InputListTile extends StatelessWidget {

  final String label;
  final String value;
  final void Function(String text) onSubmit;
  const InputListTile({super.key,
    required this.label,
    required this.value,
    required this.onSubmit,});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(label),
    subtitle: Text(value),
    trailing: const Icon(Icons.edit),
    onTap: () async {
      final input = await showInputDialoge(context, initialValue: value, hintText: label);
      if (input != null) onSubmit(input);
    },
  );

}