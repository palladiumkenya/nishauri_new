import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/utils/constants.dart';

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
          final artGroups = ref.watch(art_group_provider);
          return artGroups.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: data[index].isCurrent == true
                        ? theme.colorScheme.primary
                        : null,
                  ),
                  title: Text(data[index].group.title),
                  subtitle: Text("From: ${data[index].createdAt} To: 31st Apr 2024"),
                  trailing: data[index].isCurrent == true
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
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
