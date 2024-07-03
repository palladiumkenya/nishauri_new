import 'package:flutter/material.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/utils/constants.dart';

class ViralLoadResults extends StatelessWidget {
  final List<ViralLoad> data;
  const ViralLoadResults({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(Constants.SIDE_SPACE),
        //   child: Text(
        //     "Viral Load Results",
        //     style: theme.textTheme.headline6,
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final color = data[index].status == "Viral unsuppressed"
                  ? Colors.red
                  : Colors.green;
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[index].status,
                                      style: TextStyle(
                                        color: color,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index].status == "Viral unsuppressed"
                                                    ? 'Viral unsuppressed (${data[index].plot})'
                                                    : 'Viral Suppressed (${data[index].plot})',
                                                style: theme.textTheme.headline6,
                                              ),
                                              const Divider(),
                                              // Add a Divider widget to separate the title and content
                                            ],
                                          ),
                                          content: Text(
                                            data[index].status == "Viral unsuppressed"
                                                ? 'This could mean the beginning of treatment failure. Kindly visit your doctor/healthcare provider as soon as possible!'
                                                : 'This means you are adhering to your treatment well. Continue taking your medication as advised by your doctor/healthcare provider.',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      icon: const Icon(Icons.info_outline),
                                      color: color.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.diamond_outlined,
                                      color: color,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(
                                      data[index].result,
                                      style: TextStyle(
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: color,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(
                                      data[index].date,
                                      style: TextStyle(
                                        color: color
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
