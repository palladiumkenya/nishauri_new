import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class Literature extends HookConsumerWidget {
  const Literature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentAppointmentSync = ref.watch(appointmentProvider(false));
    return currentAppointmentSync.when(
      data: (data) {
        final activeProgramAppointments =
        data.where((element) => element.program_status.toString() == "1");
        if (activeProgramAppointments.isEmpty) {
          return BackgroundImageWidget(
              svgImage: "assets/images/appointments-empty.svg",
              notFoundText: "No videos found",
              floatingButtonIcon1: Icons.refresh,
              floatingButtonAction1: () {
                ref.refresh(appointmentProvider(false));
              }
          );
        }
        return Scaffold(
          body: Column(
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
                                      const Icon(
                                        Icons.app_registration_outlined,
                                        color: Constants.appointmentsColor,
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text(
                                        currAppointment.appointment_type ?? '',
                                      ),
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
                                      Text(
                                        currAppointment.appointment_date,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.local_hospital_sharp,
                                        color: Constants.appointmentsColor,
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text(
                                        currAppointment.facility_name ?? '',
                                      ),
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.refresh(appointmentProvider(false));
            },
            child: Icon(Icons.refresh),
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
          svgImage: 'assets/images/background.svg',
          notFoundText: error.toString(),
          floatingButtonIcon1: Icons.refresh,
          floatingButtonAction1: () {
            ref.refresh(appointmentProvider(false));
          }
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Literature",
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