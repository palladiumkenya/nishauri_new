import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/RescheduleDatePicker.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/RescheduleTimePicker.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/helpers.dart';

import '../../../../utils/constants.dart';

class AppointmentRescheduleScreenProps {
  final String appointmentType;
  final DateTime appointmentTime;
  final String providerImage;
  final String providerName;
  final Future<dynamic> Function(
      DateTime rescheduleTime, String rescheduleReason)? onSubmit;

  AppointmentRescheduleScreenProps(
      {required this.appointmentTime,
      required this.appointmentType,
      required this.providerName,
      required this.providerImage,
      this.onSubmit});
}

class AppointmentRescheduleScreen extends HookWidget {
  final AppointmentRescheduleScreenProps props;

  const AppointmentRescheduleScreen({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final String appointmentType = props.appointmentType;
    final DateTime appointmentTime = props.appointmentTime;
    final String providerImage = props.providerImage;
    final String providerName = props.providerName;
    final Future<dynamic> Function(
    DateTime rescheduleTime, String rescheduleReason)? onSubmit = props.onSubmit;
    final theme = Theme.of(context);
    final size = getOrientationAwareScreenSize(context);
    final selectedDate = useState<DateTime?>(null);
    final selectedTime = useState<DateTime?>(null);
    final rescheduleReason = useState<String>("");
    final loading = useState(false);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          context.pop();
        },
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Curr Appointment
              Row(
                children: [
                  // Image rounded border
                  Container(
                    padding: const EdgeInsets.all(Constants.SPACING * 0.5),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Constants.ROUNDNESS * 3),
                      border: Border.all(
                        width: 1,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    // Image
                    child: Container(
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Constants.ROUNDNESS * 3),
                        image: DecorationImage(
                          image: NetworkImage(providerImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Text columns
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.SPACING),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          providerName,
                          style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Row(
                          children: [
                            Text(
                              DateFormat("EEE, MMM dd").format(appointmentTime),
                              style: theme.textTheme.titleMedium?.copyWith(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.SPACING),
                              child: Text(
                                ".",
                                style: theme.textTheme.titleMedium?.copyWith(),
                              ),
                            ),
                            Text(
                              appointmentType,
                              style: theme.textTheme.titleMedium?.copyWith(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: Constants.SPACING),
              RescheduleDatePicker(
                appointmentTime: appointmentTime,
                selectedDate: selectedDate.value,
                onSelectedDateChange: (date) {
                  selectedDate.value = date;
                },
              ),
              const SizedBox(height: Constants.SPACING),
              RescheduleTimePicker(
                activeColor: Constants.activeSelectionColor,
                selectedTime: selectedTime.value,
                onSelectedTimeChange: (time) => selectedTime.value = time,
              ),
              const SizedBox(height: Constants.SPACING),
              Text("Reschedule Reason", style: theme.textTheme.titleMedium),
              const SizedBox(height: Constants.SPACING),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: TextField(
                  onChanged: (value) {
                    rescheduleReason.value = value;
                  },
                  minLines: 4,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: theme.colorScheme.primary.withOpacity(0.1),
                    hintText: "Type your message here ...",
                  ),
                ),
              ),
              const SizedBox(height: Constants.SPACING),
              Button(
                title: "Submit Request",
                backgroundColor: Constants.activeSelectionColor,
                textColor: theme.canvasColor,
                loading: loading.value,
                // prefixIcon: const Icon(Icons.downloading),
                surfixIcon: SvgPicture.asset(
                  "assets/images/history.svg",
                  semanticsLabel: "Doctors",
                  fit: BoxFit.contain,
                ),

                disabled: selectedTime.value == null ||
                    selectedDate.value == null ||
                    rescheduleReason.value.isEmpty ||
                    onSubmit == null,
                onPress: () {
                  final time = DateTime(
                    selectedDate.value!.year,
                    selectedDate.value!.month,
                    selectedDate.value!.day,
                    selectedTime.value!.hour,
                    selectedTime.value!.minute,
                  );
                  loading.value = true;
                  onSubmit!(time, rescheduleReason.value).then((value) {
                    context.pop();
                  }).catchError((e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }).whenComplete(() => loading.value = false);
                },
              ),
              const SizedBox(height: Constants.SPACING),
            ],
          ),
        ),
      ),
    );
  }
}
