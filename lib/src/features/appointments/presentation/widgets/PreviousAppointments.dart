import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class PreviousAppointments extends HookConsumerWidget {
  const PreviousAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentAppointmentSync = ref.watch(appointmentProvider(true));
    return currentAppointmentSync.when(
      data: (data) {
        // Filter appointments with program_status == 1
        final filteredAppointments = data.where((appointment) => appointment.program_status == 1).toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: filteredAppointments.isNotEmpty ? ListView.builder(
                itemCount: filteredAppointments.length,
                itemBuilder: (BuildContext context, int index) {
                  final appointment = filteredAppointments[index];
                  final color = appointment.appt_status == "Missed" ? Colors.red : theme.colorScheme.primary;
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
                                  appointment.program_name ?? '',
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
                                    Text(appointment.appointment_type ?? ''),
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
                                    Text(appointment.appointment_date),
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
                                    Text(appointment.appt_status ?? ''),
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
              ) : Center(
                child: BackgroundImageWidget(
                  svgImage: 'assets/images/background.svg',
                  notFoundText: "No appointment found",
                ),
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
