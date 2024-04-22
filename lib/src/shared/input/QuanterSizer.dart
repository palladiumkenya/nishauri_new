import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../utils/helpers.dart';

class Quantizer extends StatelessWidget {
  final String label;
  final String? units;
  final int value;
  final int? min;
  final int? max;
  final void Function(int value) onValueChange;

  const Quantizer(
      {super.key,
      required this.value,
      required this.onValueChange,
      required this.label,
      this.units,
      this.min,
      this.max});

  @override
  Widget build(BuildContext context) {
    final screenSize = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    final color = theme.canvasColor;
    final bgColor = theme.colorScheme.primary;
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: theme.colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.all(Constants.SPACING),
        width: screenSize.width * 0.45,
        height: screenSize.width * 0.45,
        decoration: BoxDecoration(color: theme.canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.titleLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.filled(
                  onPressed: () {
                    if(min != null && value <= min!) {
                      return;
                    }
                    onValueChange(value - 1);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text("$value", style: theme.textTheme.headlineLarge ,),
                IconButton.filled(
                  onPressed: () {
                    if(max != null && value >= max!) {
                      return;
                    }
                    onValueChange(value + 1);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Text(
              units ?? "",
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.disabledColor),
            ),
          ],
        ),
      ),
    );
  }
}
