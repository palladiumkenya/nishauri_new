import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/lab/data/providers/VirolLoadprovider.dart';
import 'package:nishauri/src/features/lab/presentation/pages/LabResults.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadResult.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadTrend.dart';
import 'package:nishauri/src/utils/constants.dart';

class LabResultsScreen extends ConsumerWidget {
  const LabResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final labAsync = ref.watch(viralLoadProvider);

    return labAsync.when(data: (data)
    {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left),
            ),
            title: const Text("ART Lab Results"),
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.medication), text: "Viral Load Results"),
                Tab(icon: Icon(Icons.auto_graph_outlined), text: "Viral Load Trend"),
              ],
              labelColor: theme.colorScheme.onPrimary,
            ),
          ),
          body: FractionallySizedBox(
            heightFactor: 1,
            child: TabBarView(
              children: [
                ViralLoadResults(data: data),
                ViralLoadTrend(data: data),
              ],
            ),
          ),
        ),
      );
    },
        error: (error, _) => Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.toString(),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
          ],
        )),
        // Text(error.toString())),
        loading: ()  => Center(
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
  }
}
