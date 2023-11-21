import 'package:flutter/material.dart';

class MultiChoiceCheckListChoice {
  final String label;
  final String value;

  MultiChoiceCheckListChoice({required this.label, required this.value});
}

class MultiChoiceCheckList extends StatelessWidget {
  final String label;
  final List<MultiChoiceCheckListChoice> items;
  final List<MultiChoiceCheckListChoice> value;
  final void Function(List<MultiChoiceCheckListChoice> value)? onValueChanged;

  const MultiChoiceCheckList({
    super.key,
    required this.items,
    required this.label,
    this.onValueChanged,
    this.value = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium ),
        ...items
            .map(
              (e) => CheckboxListTile(
                value: value.any((element) => element.value == e.value),
                onChanged: onValueChanged != null
                    ? (isChecked) {
                        if (value.any((element) => element.value == e.value)) {
                          // If in value then remove
                          onValueChanged!(value
                              .where((element) => element.value != e.value)
                              .toList());
                        } else {
                          // else add to value
                          onValueChanged!(value..add(e));
                        }
                      }
                    : null,
                title: Text(e.label),
              ),
            )
            .toList()
      ],
    );
  }
}
