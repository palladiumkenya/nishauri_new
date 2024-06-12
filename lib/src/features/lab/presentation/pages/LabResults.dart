import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/lab/data/providers/VirolLoadprovider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class LabResults extends StatelessWidget {
  const LabResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Lab Results 🧪"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final labResultsAsync = ref.watch(viralLoadProvider);
          return labResultsAsync.when(
            data: (data) => Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(Constants.SPACING),
                  child: Text("Viral Load Results"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final color = data[index].status == "Viral unsuppressed"
                          ? Colors.red
                          : Colors.greenAccent;
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].status == "Viral unsuppressed"
                                          ? 'Viral unsuppressed (${data[index].plot})'
                                          : 'Viral Suppressed (${data[index].plot})',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Divider(), // Add a Divider widget to separate the title and content
                                  ],
                                ),
                                content: Text(
                                  data[index].status == "Viral unsuppressed"
                                      ? 'This could mean the beginning of treatment failure, Kindly visit your doctor/healthcare provider as soon as possible!'
                                      : 'This means you are adhering to your treatment well, Continue taking your medication as advised by your doctor/healthcare provider',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                            leading:
                                const Icon(Icons.medical_information_rounded),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" ${data[index].date} ",
                                    style: theme.textTheme.titleMedium),
                                Text(
                                  " ${data[index].result} ",
                                  style: theme.textTheme.titleSmall?.merge(
                                    TextStyle(
                                      color: color,
                                    ),
                                  ),
                                ),
                                Text(
                                  " ${data[index].status} ",
                                  style: theme.textTheme.titleSmall?.merge(
                                    TextStyle(
                                      color: color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.info_outline, color: color),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            error: (error, _) => BackgroundImageWidget(
              svgImage: 'assets/images/background.svg',
              notFoundText: error.toString(),
            ),
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Loading Lab Results",
                    style: theme.textTheme.headline6,
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
