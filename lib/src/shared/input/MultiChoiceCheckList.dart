import 'package:flutter/material.dart';

class MultiChoiceCheckList extends StatelessWidget {
  const MultiChoiceCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.vertical,
      children: [
        Text("Any illness?", style: theme.textTheme.titleMedium,),
      ],
    );
  }
}
