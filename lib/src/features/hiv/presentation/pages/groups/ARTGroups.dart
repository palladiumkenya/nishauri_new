import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => Card(
          child: ListTile(
            leading: Icon(
              Icons.group,
              color: index == 2 ? theme.colorScheme.primary : null,
            ),
            title: Text("Group $index"),
            subtitle: const Text("From: 28th Nov 2023 To: 31st Apr 2024"),
            trailing: index == 2
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
    );
  }
}
