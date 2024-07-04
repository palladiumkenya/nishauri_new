import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/appointments/presentation/pages/AppointmentRescheduleScreen.dart';
import 'package:nishauri/src/features/common/presentation/widgets/AppointmentCard.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/interfaces/notification_service.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import '../../../../utils/constants.dart';
import '../../../dawa_drop/data/providers/drug_order_provider.dart';

class Appointments extends HookConsumerWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentProvider(false));
    final appointmentsNotifier = ref.watch(appointmentProvider(false).notifier);
    final screenSize = getOrientationAwareScreenSize(context);
    final pendingOrders = ref
            .watch(drugOrderProvider)
            .valueOrNull
            ?.where((order) => order.status != 'Fullfilled')
            .toList() ??
        [];

    final theme = Theme.of(context);
    return appointmentsAsync.when(
      data: (data) {
        final activeProgramAppointments =
            data.where((element) => element.program_status.toString() == "1");
        // Subscribes to the appointments topic
        _saveAndSubscribeToProgramAppointments(activeProgramAppointments);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.SPACING),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming appointments",
                    style: theme.textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: () {
                      context.goNamed(
                        RouteNames.APPOINTMENTS,
                      );
                    },
                    child: Text(
                      "View all",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
            if (activeProgramAppointments.isEmpty)
              DecoratedBox(
                decoration: const BoxDecoration(),
                child: SvgPicture.asset(
                  "assets/images/appointments-empty.svg",
                  semanticsLabel: "Doctors",
                  fit: BoxFit.contain,
                  height: 150,
                ),
              ),
            if (activeProgramAppointments.isEmpty)
              Text(
                "No upcoming appointments today",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            if (activeProgramAppointments.isNotEmpty)
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activeProgramAppointments.map(
                      (artAppointment) {
                        return Builder(
                          builder: (BuildContext context) {
                            final appointmentDate = DateTime.parse(
                                artAppointment.appointment
                                        ?.split("-")
                                        .reversed
                                        .join("-") ??
                                    DateTime.now().toIso8601String());
                            final size = getOrientationAwareScreenSize(context);

                            return GestureDetector(
                              onTap: () {
                                context.goNamed(
                                  RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                                  extra: artAppointment,
                                );
                              },
                              child: SizedBox(
                                width: size.width * 0.99,
                                child: AppointmentCard(
                                  rescheduleButtonText: pendingOrders.isNotEmpty
                                      ? "Has active order"
                                      : (artAppointment.reschedule_status
                                                  .toString() ==
                                              "0"
                                          ? "Pending approval"
                                          : artAppointment.reschedule_status
                                                      .toString() ==
                                                  "1"
                                              ? "Approved"
                                              : null),
                                  appointmentType:
                                      artAppointment.appointment_type ??
                                          "Unknown type",
                                  appointmentTime: appointmentDate,
                                  providerImage:
                                      "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                                  providerName:
                                      artAppointment.facility_name ?? '',
                                  onRescheduleTap: artAppointment
                                                  .reschedule_status ==
                                              null ||
                                          artAppointment.reschedule_status
                                                  .toString() ==
                                              "2"
                                      ? () => context.goNamed(
                                            RouteNames.APPOINTMENTS_RESCHEDULE,
                                            extra:
                                                AppointmentRescheduleScreenProps(
                                              appointmentTime: appointmentDate,
                                              appointmentType: artAppointment
                                                      .appointment_type ??
                                                  "Unknown type",
                                              providerName: artAppointment
                                                      .facility_name ??
                                                  "Unknown Facility",
                                              providerImage:
                                                  "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                                              onSubmit: artAppointment
                                                              .reschedule_status ==
                                                          null ||
                                                      artAppointment
                                                              .reschedule_status
                                                              .toString() ==
                                                          "2"
                                                  ? (date, reason) async {
                                                      return await appointmentsNotifier
                                                          .rescheduleAppointment({
                                                        "appt_id":
                                                            artAppointment.id,
                                                        "reason": reason,
                                                        "reschedule_date": date
                                                            .toIso8601String()
                                                      });
                                                    }
                                                  : null,
                                            ),
                                          )
                                      : null,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  )),
          ],
        );
      },
      error: (error, _) => Container(),
      loading: () => const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Loading appointments "),
              CircularProgressIndicator()
            ]),
      ),
    );
  }

  Future<void> _saveAndSubscribeToProgramAppointments(var appointments) async {
    String activeProgramAppointments = jsonEncode(
        appointments.map((appointment) => appointment.toJson()).toList());
    await LocalStorage.save(
        'active_program_appointments', activeProgramAppointments);

    // Retrieve dispatched orders from local storage
    String? cachedProgramAppointmentsJson =
        await LocalStorage.get('active_program_appointments');

    List<Appointment> cachedActiveProgramAppointments =
        (jsonDecode(cachedProgramAppointmentsJson) as List)
            .map((appointmentJson) => Appointment.fromJson(appointmentJson))
            .toList();

    NotificationService.subscribeToTopic(
        cachedActiveProgramAppointments, SubscriptionType.appointments);
  }
}
