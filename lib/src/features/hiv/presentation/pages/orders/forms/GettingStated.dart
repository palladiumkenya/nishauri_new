import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GettingStarted extends StatelessWidget {
  final ARTAppointment? artAppointment;
  final ARTEvent? artEvent;
  final String? type;

  const GettingStarted(
      {super.key, this.artEvent, this.artAppointment, this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
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
              const SizedBox(height: Constants.SPACING),
            ],
          ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
