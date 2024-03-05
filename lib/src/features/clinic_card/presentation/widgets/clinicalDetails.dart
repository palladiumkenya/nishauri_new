import 'package:flutter/material.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class ClinicalDetailsTab extends StatelessWidget {
  final Program program;
  const ClinicalDetailsTab({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Program Details",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: program.items.length,
            itemBuilder: (BuildContext context, int index) {
              final itemName = program.items.keys.toList()[index];
              final itemValue = program.items.values.toList()[index];
              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.file_present),
                    title: Text(itemName),
                    subtitle: Text(itemValue),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
