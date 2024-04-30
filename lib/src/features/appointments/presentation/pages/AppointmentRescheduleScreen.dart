import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/RescheduleDatePicker.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/RescheduleTimePicker.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/helpers.dart';

import '../../../../utils/constants.dart';

class AppointmentRescheduleScreen extends HookWidget {
  const AppointmentRescheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = getOrientationAwareScreenSize(context);
    final providerName = "Dr John Doe";
    final providerImage =
        "https://www.insurancejournal.com/wp-content/uploads/2014/03/hospital.jpg";
    final appointmentTime = DateTime(2024, 05, 3);
    final appointmentType = "Re-Fill";
    final selectedDate = useState<DateTime?>(null);
    final selectedTime = useState<DateTime?>(null);
    final rescheduleReason = useState<String>("");
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
                activeColor: Colors.green,
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
                backgroundColor: Colors.green,
                textColor: theme.canvasColor,
                // prefixIcon: const Icon(Icons.downloading),
                surfixIcon: const Icon(Icons.upload_outlined),
                onPress: () {

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
