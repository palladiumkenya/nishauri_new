import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/shared/display/ProfileCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTEventDetailScreen extends StatelessWidget {
  final String eventId;

  const ARTEventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        // title: const Text("ART Groups"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final artEventsAsync = ref.watch(art_event_provider);
          return artEventsAsync.when(
            data: (artEvents) {
              final artEvent =
                  artEvents.where((element) => element.id == eventId).first;
              return ProfileCard(
                icon: Icons.event,
                coverPhoto: "https://picsum.photos/seed/picsum/200/300",
                buildItem: (context, item) => item,
                height: MediaQuery.of(context).size.height,
                header: Column(
                  children: [
                    Center(
                      child: Text(artEvent.title,
                          style: theme.textTheme.headlineMedium),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(Constants.SPACING),
                            padding: const EdgeInsets.all(Constants.SPACING),
                            decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Constants.ROUNDNESS),
                                )),
                            child: Text(DateFormat("dd MMM yyyy hh:mm").format(
                                DateTime.parse(artEvent.distributionTime))),
                          ),
                          CircleAvatar(
                              child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
                // bodyContainerDecoration: BoxDecoration(color: theme.colorScheme.secondary),
                items: [
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.map)),
                    title: const Text("Venue"),
                    subtitle: Text(artEvent.venue),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.group)),
                    title: const Text("Group"),
                    subtitle: Text(artEvent.group.title),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.watch_later)),
                    title: const Text("Time"),
                    subtitle: Text(DateFormat("dd MMM yyyy hh:mm")
                        .format(DateTime.parse(artEvent.distributionTime))),
                  ),
                  const Divider(),
                  ExpansionTile(
                    title: const Text("Notification reminders"),
                    leading:
                        const CircleAvatar(child: Icon(Icons.notifications)),
                    subtitle: Text(
                        "${artEvent.reminderNotificationDates.length} Reminders"),
                    children: artEvent.reminderNotificationDates
                        .map((e) => ListTile(
                              leading: Icon(Icons.watch_later_outlined),
                              title: Text(
                                DateFormat("dd MMM yyyy hh:mm").format(
                                  DateTime.parse(e),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const Divider(),
                  const ExpansionTile(
                    title: Text("Event description"),
                    leading: CircleAvatar(child: Icon(Icons.info)),
                    subtitle: Text("Brief descriptions truncated ...."),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Constants.SPACING),
                        child: Text("""What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a type 
specimen book. It has survived not only five centuries, but also the leap  """),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
