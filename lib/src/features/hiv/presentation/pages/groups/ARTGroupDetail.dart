import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/shared/display/ProfileCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTGroupDetailScreen extends StatelessWidget {
  final String groupId;

  const ARTGroupDetailScreen({super.key, required this.groupId});

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
          final artGroupsAsync = ref.watch(art_group_provider);
          return artGroupsAsync.when(
            data: (artGroups) {
              final artGroup =
                  artGroups.where((element) => element.id == groupId).first;
              return ListView(
                children: [
                  ProfileCard(),
                  ListTile(
                    title: const Text("Title"),
                    subtitle: Text(artGroup.group.title),
                    leading: const CircleAvatar(child: Icon(Icons.group)),
                  ),
                  const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text("Lead"),
                    subtitle: Text("Omondi Laurent Ouma"),
                  ),
                  const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text("Lead"),
                    subtitle: Text("Omondi Laurent Ouma"),
                  ),
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
