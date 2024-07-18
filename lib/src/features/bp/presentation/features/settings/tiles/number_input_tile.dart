import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/presentation/components/input_dialoge.dart';

class NumberInputListTile extends StatelessWidget {

  final String label;
  final Widget? leading;
  final num? value;
  final void Function(double result) onParsableSubmit;
  const NumberInputListTile(
      {super.key,
        required this.label,
        this.leading,
        this.value,
        required this.onParsableSubmit,});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(label),
    subtitle: Text(value.toString()),
    leading: leading,
    trailing: const Icon(Icons.edit),
    onTap: () async {
      final result = await showNumberInputDialoge(context,
        initialValue: value,
        hintText: label,
      );
      if (result != null) onParsableSubmit(result);
    },
  );
}