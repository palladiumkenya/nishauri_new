import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/appointments/presentation/pages/AppointmentRescheduleScreen.dart';
import 'package:nishauri/src/features/common/presentation/widgets/AppointmentCard.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import '../../../../utils/constants.dart';

class Appointments extends HookConsumerWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentProvider(false));
    final appointmentsNotifier = ref.watch(appointmentProvider(false).notifier);
    final screenSize = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    return appointmentsAsync.when(
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING),
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
          if (data.isEmpty)
            DecoratedBox(
              decoration: const BoxDecoration(),
              child: SvgPicture.asset(
                "assets/images/appointments-empty.svg",
                semanticsLabel: "Doctors",
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
          if (data.isEmpty)
            Text(
              "No upcoming appointments today",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          if (data.isNotEmpty)
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.map(
                    (artAppointment) {
                      return Builder(
                        builder: (BuildContext context) {
                          final appointmentDate = DateTime.parse(artAppointment
                                  .appointment
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
                                appointmentType:
                                    artAppointment.appointment_type ??
                                        "Unknown type",
                                appointmentTime: appointmentDate,
                                providerImage:
                                    "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                                providerName: "Kiseuni Dispensary",
                                onRescheduleTap: () => context.goNamed(
                                  RouteNames.APPOINTMENTS_RESCHEDULE,
                                  extra: AppointmentRescheduleScreenProps(
                                      appointmentTime: appointmentDate,
                                      appointmentType:
                                          artAppointment.appointment_type ??
                                              "Unknown type",
                                      providerName: "Kiseuni Dispensary",
                                      providerImage:
                                          "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                                      onSubmit: (date, reason) async {
                                        return await appointmentsNotifier
                                            .rescheduleAppointment({
                                          "appt_id": artAppointment.id,
                                          "reason": reason,
                                          "reschedule_date":
                                              date.toIso8601String()
                                        });
                                      }),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                )),
          if (false)
            CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                // height: screenSize.height * 0.2,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
              ),
              items: data.map(
                (artAppointment) {
                  return Builder(
                    builder: (BuildContext context) {
                      final appointmentDate = DateTime.parse(artAppointment
                              .appointment
                              ?.split("-")
                              .reversed
                              .join("-") ??
                          DateTime.now().toIso8601String());
                      return GestureDetector(
                        onTap: () {
                          context.goNamed(
                            RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                            extra: artAppointment,
                          );
                        },
                        child: Wrap(
                          children: [
                            AppointmentCard(
                              appointmentType:
                                  artAppointment.appointment_type ??
                                      "Unknown type",
                              appointmentTime: appointmentDate,
                              providerImage:
                                  "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                              providerName: "Kiseuni Dispensary",
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
        ],
      ),
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
}
