import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_appointmen_provider.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_treatment_Support_provider.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class GettingStarted extends HookConsumerWidget {
  final Appointment? artAppointment;
  final ARTEvent? artEvent;
  final String? type;

  const GettingStarted(
      {super.key, this.artEvent, this.artAppointment, this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncARTAppointments = ref.watch(appointmentProvider);
    final asyncARTEvents = ref.watch(art_event_provider);
    final asyncARTTreatmentSupport = ref.watch(artTreatmentSupportProvider);
    final orderType = useState<String?>(type);
    // final orderMode = useState<String?>(artEvent != null
    //     ? "event"
    //     : artAppointment != null
    //         ? "appointment"
    //         : null);
    final orderMode = "Appointment";
    return Column(
      children: [
        // FormBuilderRadioGroup<String>(
        //     name: 'mode',
        //     initialValue: "Appointment",
        //
        //     decoration: const InputDecoration(
        //       border: InputBorder.none,
        //       labelText: "Request based on",
        //     ),
        //     validator: FormBuilderValidators.compose([
        //       FormBuilderValidators.required(errorText: "Required"),
        //     ]),
        //     options: const [
        //       // FormBuilderFieldOption(
        //       //   value: "Event",
        //       //   child: ListTile(
        //       //     title: Text("Event"),
        //       //   ),
        //       // ),
        //       FormBuilderFieldOption(
        //         value: "Appointment",
        //         child: ListTile(
        //           title: Text("Appointment"),
        //         ),
        //       ),
        //     ]),
        // const SizedBox(height: Constants.SPACING),
        // Hidden field for ccc_no
        const SizedBox(height: Constants.SPACING),
        FormBuilderTextField(
          name: 'mode',
          initialValue: "Appointment",
          enabled: false,
          decoration: inputDecoration(
            label: "Request based on",
            prefixIcon: Icons.real_estate_agent_outlined,
          ),
        ),
        // FormInputTextField(
        //     name: 'order_type',
        //     onChanged: (type_) {
        //       orderType.value = type_;
        //     },
        //     initialValue: type,
        //     decoration: const InputDecoration(
        //       border: InputBorder.none,
        //       labelText: "Who are you requesting for?",
        //     ),
        //     validator: FormBuilderValidators.compose([
        //       FormBuilderValidators.required(errorText: "Required"),
        //     ]),
        //     options: const [
        //       FormBuilderFieldOption(
        //         value: "Self",
        //         child: ListTile(
        //           title: Text("Yourself"),
        //         ),
        //       ),
        //       // FormBuilderFieldOption(
        //       //   value: "other",
        //       //   child: ListTile(
        //       //     title: Text("Care receiver"),
        //       //   ),
        //       // ),
        //     ]),
        const SizedBox(height: Constants.SPACING),
        // Hidden field for ccc_no
        FormBuilderTextField(
          name: 'order_type',
          initialValue: "Self",
          enabled: false,
          decoration: inputDecoration(
            label: "Request is for",
            prefixIcon: Icons.account_circle,
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        // Hidden field for ccc_no
        FormBuilderTextField(
          name: "ccc_no",
          initialValue: artAppointment?.ccc_no,
          enabled: false,
          decoration: inputDecoration(
            label: "CCC Number",
            prefixIcon: Icons.abc_sharp,
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        if (orderMode == "Appointment")
          asyncARTAppointments.when(
            data: (appointment) => FormBuilderDropdown(
              name: "appointment_id",
              enabled: false,
              decoration: inputDecoration(
                prefixIcon: Icons.calendar_today,
                label: "Appointment",
              ),
              initialValue: artAppointment?.id,
              validator: FormBuilderValidators.compose([
                if (orderMode == "appointment")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
              items: appointment
                  .where((element) =>
                      element.appointment_type == "Re-Fill" &&
                          DateFormat('EEEE, MMMM d y').parse(element.appointment_date)
                              .difference(DateTime.now())
                              .inDays >=
                          0)
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(
                        "${e.appointment_type} " " (${DateFormat("dd MMM yyy").format(DateFormat('EEEE, MMMM d y').parse(e.appointment_date))})",
                      ),
                    ),
                  )
                  .toList(),
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        if (orderMode == "event")
          asyncARTEvents.when(
            data: (events) => FormBuilderDropdown(
              initialValue: artEvent?.id,
              name: "event",
              decoration: inputDecoration(
                prefixIcon: Icons.calendar_today,
                label: "Event",
              ),
              validator: FormBuilderValidators.compose([
                if (orderMode == "event")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
              items: events
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(
                        "${e.title}(${DateFormat("dd MMM yyy").format(DateTime.parse(e.distributionTime))})",
                      ),
                    ),
                  )
                  .toList(),
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        if (orderType.value == "other")
          const SizedBox(height: Constants.SPACING),
        if (orderType.value == "other")
          asyncARTTreatmentSupport.when(
            data: (supports) => FormBuilderDropdown(
              name: "careReceiver",
              decoration: inputDecoration(
                prefixIcon: Icons.person,
                label: "Care receiver",
              ),
              validator: FormBuilderValidators.compose([
                if (orderType.value == "other")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
              items: supports
                  // TODO Filter only where curr user is care giver
                  .where((element) => true)
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.careReceiver.cccNumber,
                      child: Text(
                        "${e.careReceiver.name}(${e.careReceiver.cccNumber})",
                      ),
                    ),
                  )
                  .toList(),
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        const SizedBox(height: Constants.SPACING),
      ],
    );
  }
}
