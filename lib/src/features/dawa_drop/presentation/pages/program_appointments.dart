import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProgramAppointmentsScreen extends ConsumerWidget {
  const ProgramAppointmentsScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appointmentAsync = ref.watch(appointmentProvider(false));

    return appointmentAsync.when(
      data: (data) {
        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "Appointments",
                icon: Icons.vaccines_sharp,
                color: Constants.dawaDropColor.withOpacity(0.5),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final appointment = data[index];
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
                                    data[index].program_name ?? '',
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
                                      Text(data[index].appointment_type??''),
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
                                      Text(data[index].appointment_date),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            context.goNamed(
                              RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                              extra: appointment,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (data.isEmpty)
                Expanded(
                  child: BackgroundImageWidget(
                    svgImage: 'assets/images/background.svg',
                    notFoundText: "No Appointments",
                  ),
                ),
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        customAppBar: CustomAppBar(
          title: "Appointments",
          icon: Icons.vaccines_sharp,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        svgImage: 'assets/images/background.svg',
        notFoundText: error.toString(),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Upcoming Appointments",
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
