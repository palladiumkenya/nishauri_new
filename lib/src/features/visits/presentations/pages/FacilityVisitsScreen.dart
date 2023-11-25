import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/providers/visits_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class FacilityVisitsScreen extends StatelessWidget {
  const FacilityVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Facility visits"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final visitsAsync = ref.watch(visitProvider);
          return visitsAsync.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => AppCard(
                onTap: () => context.goNamed(
                  RouteNames.FACILITY_VISIT_DETAIL,
                  pathParameters: {"visitId": data[index].uuid},
                ),
                child: ListTile(
                    leading: const Icon(
                      Icons.move_down,
                    ),
                    title: Text(data[index].visitDate),
                    subtitle: Text(
                        "From: ${DateFormat("yyyy MMM dd").format(DateTime.parse(data[index].visitDate))}"),
                    trailing: const Icon(Icons.chevron_right)),
              ),
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Loading your visits",
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
