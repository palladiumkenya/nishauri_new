import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTEventsScreen extends ConsumerWidget {
  const ARTEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final events = ref.watch(art_event_provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ART Events"),
      ),
      body: events.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Card(
            child: ListTile(
              leading: const Icon(
                Icons.group,
              ),
              title: Text(data[index].title),
              subtitle: Text(data[index].distributionTime),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading Events",
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: Constants.SPACING * 2),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
