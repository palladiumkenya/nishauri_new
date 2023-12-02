import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_regimen_provider.dart';
import 'package:nishauri/src/utils/constants.dart';

class RegimenHistoryScreen extends ConsumerWidget {
  const RegimenHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final regimen = ref.watch(art_regimen_provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Regimen History"),
      ),
      body: regimen.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Column(
            children: [
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.medication,
                  color: data[index].isCurrent ? theme.colorScheme.primary : null,
                ),
                title: Text(data[index].name),
                subtitle:  Text("From: ${data[index].createdAt} To: 31st Apr 2024"),
                trailing: data[index].isCurrent
                    ? Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Constants.ROUNDNESS),
                          ),
                        ),
                        child: const Text("Current"),
                      )
                    : null,
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
                "Loading Your Regimen History",
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
