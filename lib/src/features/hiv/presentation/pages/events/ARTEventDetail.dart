import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/shared/display/ProfileCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ARTEventDetailScreen extends HookConsumerWidget {
  final String eventId;

  const ARTEventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IconData lastTapped = Icons.notifications;
    final List<IconData> menuItems = <IconData>[
      Icons.home,
      Icons.new_releases,
      Icons.notifications,
      Icons.settings,
      Icons.menu,
    ];
    final artEventsAsync = ref.watch(art_event_provider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        // title: const Text("ART Groups"),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: artEventsAsync.when(
          data: (data) => ExpandableFab(
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.more_vert),
                  fabSize: ExpandableFabSize.regular,
                  shape: const CircleBorder(),
                ),
                closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                  child: const Icon(Icons.close),
                  fabSize: ExpandableFabSize.small,
                  foregroundColor: Colors.deepOrangeAccent,
                  shape: const CircleBorder(),
                ),
                type: ExpandableFabType.up,
                distance: 70,
                children: [
                  FloatingActionButton.extended(
                    // shape: const CircleBorder(),
                    heroTag: null,
                    label: const Text("Confirm attendance"),
                    icon: const Icon(Icons.check_circle),
                    onPressed: () {},
                  ),
                  FloatingActionButton.extended(
                    // shape: const CircleBorder(),
                    heroTag: null,
                    label: const Text("Request delivery"),
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      context.goNamed(
                        RouteNames.HIV_ART_DELIVERY_REQUEST_FORM,
                        extra: {
                          "payload": data
                              .where((element) => element.id == eventId)
                              .elementAt(0),
                          "type": "self"
                        },
                      );
                    },
                  ),
                  FloatingActionButton.extended(
                    // shape: const CircleBorder(),
                    heroTag: null,
                    label: const Text("Edit"),
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
      body: artEventsAsync.when(
        data: (artEvents) {
          final artEvent =
              artEvents.where((element) => element.id == eventId).first;
          return ProfileCard(
            icon: Icons.event,
            coverPhoto: "https://picsum.photos/seed/picsum/757/300",
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
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Constants.ROUNDNESS),
                            )),
                        child: Text(DateFormat("dd MMM yyyy hh:mm")
                            .format(DateTime.parse(artEvent.distributionTime))),
                      ),
                      CircleAvatar(
                          child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.goNamed(RouteNames.HIV_ART_EVENT_FORM,
                              extra: artEvent);
                        },
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
                leading: const CircleAvatar(child: Icon(Icons.notifications)),
                subtitle: Text(
                    "${artEvent.reminderNotificationDates.length} Reminders"),
                children: artEvent.reminderNotificationDates
                    .map((e) => ListTile(
                          leading: const Icon(Icons.watch_later_outlined),
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
      ),
    );
  }
}
