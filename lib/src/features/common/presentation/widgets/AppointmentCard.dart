import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class AppointmentCard extends StatelessWidget {
  final String providerName;
  final String providerImage;
  final DateTime appointmentTime;
  final String appointmentType;
  final double width;
  final double height;

  const AppointmentCard({
    super.key,
    required this.providerName,
    required this.providerImage,
    required this.appointmentTime,
    required this.appointmentType,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      // color: Colors.red,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            clipBehavior: Clip.antiAlias, // Clip the corners of the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  Constants.ROUNDNESS * 2), // Customize corner radius
            ),
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              // width: width,
              // height: height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.onBackground, // Use app's surface color
                  theme.colorScheme.primary, // Use app's primary color
                ],
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Constants.ROUNDNESS * 2),
                          border: Border.all(
                            width: 1,
                            color: theme.canvasColor.withOpacity(0.5),
                          ),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Constants.ROUNDNESS * 2),
                            image: DecorationImage(
                              image: NetworkImage(providerImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.SPACING),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              providerName,
                              style: theme.textTheme.titleLarge
                                  ?.copyWith(color: theme.canvasColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat.jm().format(appointmentTime),
                                  style: theme.textTheme.titleSmall
                                      ?.copyWith(color: theme.canvasColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Constants.SPACING),
                                  child: Text(
                                    ".",
                                    style: theme.textTheme.titleSmall
                                        ?.copyWith(color: theme.canvasColor),
                                  ),
                                ),
                                Text(
                                  appointmentType,
                                  style: theme.textTheme.titleSmall
                                      ?.copyWith(color: theme.canvasColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: Constants.SPACING * 0.5,
                        horizontal: Constants.SPACING * 2),
                    margin: const EdgeInsets.only(top: Constants.SPACING),
                    decoration: BoxDecoration(
                      color: theme.canvasColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.ROUNDNESS),
                      ),
                    ),
                    child: Text(
                      "${appointmentTime.difference(DateTime.now()).inDays} Days left",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.canvasColor),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            right: 50,
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 2, color: theme.canvasColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.circular(Constants.ROUNDNESS * 6)
              ),
              child: Card(
                shadowColor: theme.colorScheme.primary,
                clipBehavior: Clip.antiAlias,
                // Clip the corners of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Constants.ROUNDNESS * 6,
                  ), // Customize corner radius
                ),
                // shape: const OvalBorder(),
                child: InkWell(
                    splashColor: theme.colorScheme.primary.withAlpha(30),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Constants.SPACING * 0.5,
                          horizontal: Constants.SPACING * 2),
                      child: const Row(
                        children: [
                          Icon(Icons.schedule),
                          SizedBox(width: Constants.SPACING),
                          Text("Reschedule"),
                        ],
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
