import 'package:flutter/material.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/utils/constants.dart';

class ClinicalDetailsTab extends StatelessWidget {
  final Program program;
  const ClinicalDetailsTab({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(program.name),
          subtitle: Text('Facility Name: ${program.facility_name}'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: program.obs.length,
            itemBuilder: (BuildContext context, int index) {
              final observations = program.obs[index];
              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    title: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              observations.label,
                              style: theme.textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: Constants.SPACING),
                            Row(
                              children: [
                                Icon(
                                  Icons.diamond_outlined,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: Constants.SPACING),
                                Text(observations.value?? "",),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // title: Text(observations.label, style: theme.textTheme.titleMedium,),
                    // subtitle: Text(observations.value?? "",style:TextStyle(
                    //   color: theme.primaryColor,
                    //
                    // ),),
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
