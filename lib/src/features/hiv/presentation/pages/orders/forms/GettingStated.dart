import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GettingStarted extends HookConsumerWidget {
  final ARTAppointment? artAppointment;
  final ARTEvent? artEvent;
  final String? type;

  const GettingStarted(
      {super.key, this.artEvent, this.artAppointment, this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    final orderType = useState<String?>(type);
    final orderMode = useState<String?>(artEvent != null
        ? "event"
        : artAppointment != null
            ? "appointment"
            : null);
    return asyncUser.when(
      data: (user) => Column(
        children: [
          FormBuilderRadioGroup<String>(
              name: 'mode',
              initialValue: artEvent != null
                  ? "event"
                  : artAppointment != null
                      ? "appointment"
                      : null,
              onChanged: (mode_) {
                orderMode.value = mode_;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: "Request based on",
              ),
              options: const [
                FormBuilderFieldOption(
                  value: "event",
                  child: ListTile(
                    title: Text("Event"),
                  ),
                ),
                FormBuilderFieldOption(
                  value: "appointment",
                  child: ListTile(
                    title: Text("Appointment"),
                  ),
                ),
              ]),
          FormBuilderRadioGroup<String>(
              name: 'type',
              onChanged: (type_) {
                orderType.value = type_;
              },
              initialValue: type,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: "Who are you requesting for?",
              ),
              options: const [
                FormBuilderFieldOption(
                  value: "self",
                  child: ListTile(
                    title: Text("Yourself"),
                  ),
                ),
                FormBuilderFieldOption(
                  value: "other",
                  child: ListTile(
                    title: Text("Care receiver"),
                  ),
                ),
              ]),
          if (orderMode.value == "appointment")
          FormBuilderDropdown(
            name: "appointment",
            decoration: inputDecoration(
              prefixIcon: Icons.calendar_today,
              label: "Appointment",
            ),
            items: [],
          ),
          if (orderMode.value == "event")
            FormBuilderDropdown(
              name: "event",
              decoration: inputDecoration(
                prefixIcon: Icons.calendar_today,
                label: "Event",
              ),
              items: [],
            ),
          if (orderType.value == "other")
            const SizedBox(height: Constants.SPACING),
          if (orderType.value == "other")
            FormBuilderDropdown(
              name: "careReceiver",
              decoration: inputDecoration(
                prefixIcon: Icons.person,
                label: "Care receiver",
              ),
              items: [],
            ),
          const SizedBox(height: Constants.SPACING),
        ],
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
