import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class CurrentAppointments extends HookConsumerWidget {
  const CurrentAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentAppointmentSync = ref.watch(appointmentProvider(false));
    return currentAppointmentSync.when(
      data: (data) {
        final activeProgramAppointments =
        data.where((element) => element.program_status.toString() == "1");
        if (activeProgramAppointments.isEmpty) {
          return const BackgroundImageWidget(
              svgImage: "assets/images/appointments-empty.svg",
              notFoundText: "No upcoming appointments");
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: activeProgramAppointments.length,
                itemBuilder: (BuildContext context, int index) {
                  final currAppointment =
                  activeProgramAppointments.elementAt(index);
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        title: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currAppointment.program_name ?? '',
                                  style: theme.textTheme.headline6,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.app_registration_outlined,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(
                                        currAppointment.appointment_type ?? ''),
                                  ],
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(currAppointment.appointment_date),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, _) => BackgroundImageWidget(
        svgImage: 'assets/images/background.svg',
        notFoundText: error.toString(),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Current Appointments",
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}