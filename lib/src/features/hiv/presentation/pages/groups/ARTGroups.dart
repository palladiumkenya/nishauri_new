import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ARTGroupsScreen extends StatelessWidget {
  const ARTGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ART Groups"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.goNamed(RouteNames.HIV_ART_GROUP_FORM, extra: null);
        },
        heroTag: "add-group",
        label: const Text("Add Group"),
        icon: const Icon(Icons.group_add),
        foregroundColor: theme.colorScheme.surface,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final artGroupsSubscriptionsAsync = ref.watch(art_group_provider);
          return artGroupsSubscriptionsAsync.when(
            data: (artGroupSubscriptions) => ListView.builder(
              itemCount: artGroupSubscriptions.length,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  const Divider(),
                  ListTile(
                    onTap: () => context.goNamed(
                        RouteNames.HIV_ART_GROUP_DETAIL,
                        pathParameters: {
                          "id": artGroupSubscriptions[index].id!
                        }),
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.group,
                        color: artGroupSubscriptions[index].isCurrent == true
                            ? theme.colorScheme.primary
                            : null,
                      ),
                    ),
                    title: Text(artGroupSubscriptions[index].group.title),
                    subtitle: Text(
                        "From: ${DateFormat("dd MMM yyy").format(DateTime.parse(artGroupSubscriptions[index].createdAt))}"),
                    trailing: artGroupSubscriptions[index].isCurrent == true
                        ? Container(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Constants.ROUNDNESS),
                              ),
                            ),
                            child: const Text("Current"),
                          )
                        : const Icon(Icons.chevron_right),
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
                    "Loading Your Subscribed Groups",
                    style: theme.textTheme.headlineSmall,
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
