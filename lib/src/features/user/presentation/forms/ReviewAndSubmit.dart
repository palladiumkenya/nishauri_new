import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class ReviewAndSubmit extends StatelessWidget {
  final AppFormState formState;

  const ReviewAndSubmit({super.key, required this.formState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      children: formState.values.entries
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(top: Constants.SPACING * 0.5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    Constants.ROUNDNESS,
                  ),
                ),
                color: theme.colorScheme.onPrimary
              ),
              child: ListTile(
                leading: const Icon(Icons.check),
                title: Text(e.key),
                subtitle: Text(e.value.toString(), style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),),
              ),
            ),
          )
          .toList(),
    );
  }
}
