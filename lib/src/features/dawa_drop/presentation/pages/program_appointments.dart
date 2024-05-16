import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
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
    final orderAsync = ref.watch(drugOrderProvider);

    return appointmentAsync.when(
      data: (data) {
        // Filter appointments based on the condition
        final filteredAppointments = data.where((appointment) => appointment.program_status == 1).toList();

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
                  itemCount: filteredAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = filteredAppointments[index];
                    // Check if appointment ID exists and there is an active request for it
                    final bool hasActiveRequest = appointment.id != null && orderAsync.when(
                      data: (orders) => orders.any((order) => order.appointment?.id == appointment.id),
                      loading: () => false,
                      error: (_, __) => false,
                    );

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
                                    filteredAppointments[index].program_name ?? '',
                                    style: theme.textTheme.headline6,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.app_registration_outlined,
                                        color: Constants.dawaDropColor.withOpacity(0.5),
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text(filteredAppointments[index].appointment_type ?? ''),
                                    ],
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: Constants.dawaDropColor.withOpacity(0.5),
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text(filteredAppointments[index].appointment_date),
                                    ],
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  // Display text based on whether there is an active request
                                  Text(
                                    hasActiveRequest ? "Appointment has an active request" : "Touch to Request Home delivery",
                                    style: TextStyle(
                                      color: hasActiveRequest ? Colors.grey : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Disable onTap if there is an active request
                          onTap: hasActiveRequest
                              ? null
                              : () {
                            context.goNamed(RouteNames.HIV_ART_DELIVERY_REQUEST_FORM,
                                extra: {"payload": appointment, "type": "self"});
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              // if (filteredAppointments.isEmpty)
              //   Expanded(
              //     child: Center(
              //       child: BackgroundImageWidget(
              //         svgImage: 'assets/images/background.svg',
              //         notFoundText: "No Appointments",
              //       ),
              //     ),
              //   ),
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
