import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/common/presentation/widgets/AppointmentCard.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import '../../../../utils/constants.dart';

class Appointments extends HookConsumerWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentProvider);
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
          // AppointmentCard(
          //   appointmentType: "Unknown type",
          //   appointmentTime: DateTime.parse(
          //     // artAppointment.appointment ??
          //     DateTime.now().toIso8601String(),
          //   ),
          //   providerImage:
          //       "https://www.emeraldgrouppublishing.com/sites/default/files/image/covid-cells.jpg",
          //   providerName: "Dr John Doe",
          // ),
          if(data.isEmpty)
            DecoratedBox(

              decoration: const BoxDecoration(),
              child: SvgPicture.asset(
                "assets/images/online_calendar.svg",
                semanticsLabel: "Doctors",
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
          if(data.isNotEmpty)
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              // height: screenSize.height * 0.2,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
            items: data
                .map(
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
                                artAppointment.appointment_type ?? "Unknown type",
                            appointmentTime: appointmentDate,
                            providerImage:
                                "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg",
                            providerName: "Kiseuni Dispensary",
                          ),
                        ],
                      ),
                    );
                    return AppCard(
                      onTap: () {
                        context.goNamed(
                          RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                          extra: artAppointment,
                        );
                      },
                      color: theme.colorScheme.onPrimary,
                      variant: CardVariant.ELEVETED,
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(
                            Constants.SPACING,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                Constants.ROUNDNESS,
                              ),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                        title: Text(artAppointment.appointment_type ?? '',
                            maxLines: 1),
                        titleTextStyle: theme.textTheme.titleSmall
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                            "${DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date).difference(DateTime.now()).inDays} days Remaining"),
                        subtitleTextStyle: theme.textTheme.bodySmall,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('d').format(
                                  DateFormat('EEEE, MMMM d y')
                                      .parse(artAppointment.appointment_date)),
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat("MMM").format(
                                  DateFormat('EEEE, MMMM d y')
                                      .parse(artAppointment.appointment_date)),
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
