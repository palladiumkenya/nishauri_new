import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final artGroupsAsync = ref.watch(art_group_provider);
          return artGroupsAsync.when(
            data: (artGroups) => ListView.builder(
              itemCount: artGroups.length,
              itemBuilder: (BuildContext context, int index) => AppCard(
                variant: CardVariant.ELEVETED,
                onTap: () => context.goNamed(RouteNames.HIV_ART_GROUP_DETAIL,
                    pathParameters: {"id": artGroups[index].id!}),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: artGroups[index].isCurrent == true
                        ? theme.colorScheme.primary
                        : null,
                  ),
                  title: Text(artGroups[index].group.title),
                  subtitle:
                      Text("From: ${artGroups[index].createdAt} To: 31st Apr 2024"),
                  trailing: artGroups[index].isCurrent == true
                      ? Container(
                          padding: const EdgeInsets.all(Constants.SPACING),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Constants.ROUNDNESS),
                            ),
                          ),
                          child: const Text("Current"),
                        )
                      : const Icon(Icons.chevron_right),
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
