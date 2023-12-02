import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Add Event"),
        icon: const Icon(Icons.edit_calendar_rounded),
        foregroundColor: theme.colorScheme.surface,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: events.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Column(
            children: [
              const Divider(),
              ListTile(
              onTap: ()=>context.goNamed(RouteNames.HIV_ART_EVENT_DETAILS, pathParameters: {"id": data[index].id!}),
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.event,
                  ),
                ),
                title: Text(data[index].title),
                subtitle: Text(data[index].distributionTime),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
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
