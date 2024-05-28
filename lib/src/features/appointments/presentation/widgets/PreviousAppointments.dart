import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class PreviousAppointments extends HookConsumerWidget {
  const PreviousAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final previousAppointmentsAsync = ref.watch(appointmentProvider(true));
    return previousAppointmentsAsync.when(
      data: (data) {
        final activeProgramAppointments =
        data.where((element) => element.program_status.toString() == "1");

        if (activeProgramAppointments.isEmpty) {
          return const BackgroundImageWidget(
              svgImage: "assets/images/appointments-empty.svg",
              notFoundText: "No Past appointments");
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: activeProgramAppointments.length,
                itemBuilder: (BuildContext context, int index) {
                  final color = data[index].appt_status == "Missed"
                      ? Colors.red
                      : theme.colorScheme.primary;
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
                                    const Icon(
                                      Icons.app_registration_outlined,
                                      color: Constants.appointmentsColor,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(currAppointment.appointment_type ?? ''),
                                  ],
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Constants.appointmentsColor,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(currAppointment.appointment_date),
                                  ],
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.rotate_left_outlined,
                                      color: color,
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Text(currAppointment.appt_status ?? ''),
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
              "Loading Previous Appointments",
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