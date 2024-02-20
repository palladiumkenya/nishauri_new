import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/display/AppCard.dart';
import '../../../../../shared/display/AppSearch.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/routes.dart';
import '../../../data/providers/art_appointmen_provider.dart';

class ARTTreatmentSupporters extends HookConsumerWidget {
  const ARTTreatmentSupporters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showFilters = useState<bool>(false);
    final theme = Theme.of(context);
    final filters = ["All", "Upcoming", "Past"];
    final currFilter = useState<String>("All");
    final artTreatmentSupporterAsync = ref.watch(artAppointmentProvider);

    return artTreatmentSupporterAsync.when(
      data: (artAppointments) {
        getFilteredAppointments(String filter) {
          switch (filter) {
            case "Upcoming":
              return artAppointments.where(
                      (artAppointment) => // Filter only upcoming appointments
                  DateTime.parse(artAppointment.appointmentDate)
                      .difference(DateTime.now())
                      .inDays >=
                      0);
            case "Past":
              return artAppointments.where(
                      (artAppointment) => // Filter only upcoming appointments
                  DateTime.parse(artAppointment.appointmentDate)
                      .difference(DateTime.now())
                      .inDays <
                      0);
            default:
              return artAppointments;
          }
        }

        final appointmentsToDisplay = getFilteredAppointments(currFilter.value);
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
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Text(e),
                    ),
                  ))
                      .toList(),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: appointmentsToDisplay.length,
                itemBuilder: (BuildContext context, int currIndex) => Column(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calendar_month_sharp),
                      title: Text(appointmentsToDisplay
                          .elementAt(currIndex)
                          .appointmentType),
                      subtitle: Text(
                        DateFormat("dd MMM yyy").format(
                          DateTime.parse(
                            appointmentsToDisplay
                                .elementAt(currIndex)
                                .appointmentDate,
                          ),
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.goNamed(
                          RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                          extra: artAppointments[currIndex],
                        );
                      },
                    ),
                  ],
                ),
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
    );
  }
}
