import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/models/art_treatment_support/art_treatment_support.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_treatment_Support_provider.dart';

import '../../../../../shared/display/AppCard.dart';
import '../../../../../shared/display/AppSearch.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/routes.dart';
import '../../../../user/data/models/user.dart';
import '../../../../user/data/providers/user_provider.dart';

class ARTTreatmentSupportersScreen extends HookConsumerWidget {
  const ARTTreatmentSupportersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showFilters = useState<bool>(false);
    final theme = Theme.of(context);
    final filters = ["All", "Care receivers", "Care givers"];
    final currFilter = useState<String>("All");
    final artTreatmentSupporterAsync = ref.watch(artTreatmentSupportProvider);
    final asyncUser = ref.watch(userProvider);

    return asyncUser.when(
      data: (user) => artTreatmentSupporterAsync.when(
        data: (artTreatmentSupporters) {
          // TODO Do proper implementation
          bool isCurrUserCareGiver(ARTTreatmentSupport support, User user) {
            return true;
          }

          getFilteredAppointments(String filter) {
            switch (filter) {
              case "Care receivers":
                return artTreatmentSupporters.where(
                  (artTreatmentSupporter) => // Filter only upcoming appointments
                      !isCurrUserCareGiver(artTreatmentSupporter, user),
                );
              case "Care givers":
                return artTreatmentSupporters.where(
                  (artTreatmentSupporter) => // Filter only upcoming appointments
                      isCurrUserCareGiver(artTreatmentSupporter, user),
                );
              default:
                return artTreatmentSupporters;
            }
          }

          final treatmentSupportersToDisplay =
              getFilteredAppointments(currFilter.value);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: AppSearch(onFilterPressed: () {
                  showFilters.value = !showFilters.value;
                }),
              ),
              if (showFilters.value)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters
                        .map((e) => AppCard(
                              variant: e == currFilter.value
                                  ? CardVariant.OUTLINED
                                  : CardVariant.FILLED,
                              onTap: () {
                                currFilter.value = e;
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.all(Constants.SPACING),
                                child: Text(e),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: treatmentSupportersToDisplay.length,
                  itemBuilder: (BuildContext context, int currIndex) {
                    final artTreatmentSupporter =
                        treatmentSupportersToDisplay.elementAt(currIndex);
                    final isCareGiver =
                        isCurrUserCareGiver(artTreatmentSupporter, user);
                    return Column(
                      children: [
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.calendar_month_sharp),
                          title: Text(isCareGiver
                              ? artTreatmentSupporter.careGiver.name
                              : artTreatmentSupporter.careReceiver.name),
                          subtitle: Text(
                            DateFormat("dd MMM yyy").format(
                              DateTime.parse(
                                artTreatmentSupporter.createdAt,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.goNamed(
                              RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                              extra: artTreatmentSupporters[currIndex],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading ART Appointments",
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: Constants.SPACING * 2),
              const CircularProgressIndicator(),
            ],
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
              "Loading User",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
