import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
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
              return ProfileCard(
                coverPhoto: "https://picsum.photos/seed/picsum/200/300",
                buildItem: (context, item) => item,
                height: MediaQuery.of(context).size.height,
                header: Column(
                  children: [
                    Center(
                      child: Text(artGroup.group.title,
                          style: theme.textTheme.headlineMedium),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (artGroup.isCurrent == true)
                          Container(
                            margin: const EdgeInsets.all(Constants.SPACING),
                            padding: const EdgeInsets.all(Constants.SPACING),
                            decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Constants.ROUNDNESS),
                                )),
                            child: const Text("Community ART Model"),
                          ),
                        Container(
                          margin: const EdgeInsets.all(Constants.SPACING),
                          padding: const EdgeInsets.all(Constants.SPACING),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Constants.ROUNDNESS),
                              )),
                          child: const Text("\t\tCurrent\t\t"),
                        ),
                      ],
                    ),
                  ],
                ),
                // bodyContainerDecoration: BoxDecoration(color: theme.colorScheme.secondary),
                items: [
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: const Text("Lead"),
                    subtitle: const Text("Omondi Laurent Ouma"),
                    trailing: OutlinedButton(
                      onPressed: () {},
                      child: const Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(Icons.phone),
                          Text("0793889658"),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.subscriptions)),
                    title: Text("Subscribers"),
                    subtitle: Text("12 Members"),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.subscriptions)),
                    title: Text("Offline Subscribers"),
                    subtitle: Text("4 Members"),
                  ),
                  const Divider(),
                  const ExpansionTile(

                    title: Text("Group description"),
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
