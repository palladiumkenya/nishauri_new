import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../orders/data/providers/courier_provider.dart';
import '../../../../data/providers/art_appointmen_provider.dart';
import '../../../../data/providers/art_events_provider.dart';
import '../../../../data/providers/art_treatment_Support_provider.dart';

class ReviewAndSubmit extends ConsumerWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmit({super.key, required this.formState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncARTAppointments = ref.watch(artAppointmentProvider);
    final asyncARTEvents = ref.watch(art_event_provider);
    final asyncARTTreatmentSupport = ref.watch(artTreatmentSupportProvider);
    final asyncCourierServices = ref.watch(courierProvider);
    final theme = Theme.of(context);
    return Wrap(children: [
      ListTile(
        subtitle: Text(formState["mode"] ?? "None"),
        title: const Text("Mode"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["type"] ?? "None"),
        title: const Text("Type"),
        leading: const Icon(Icons.check),
      ),
      if (formState["mode"] == "appointment")
        asyncARTAppointments.when(
          data: (data) {
            final apt = data.indexWhere(
                    (element) => element.id == formState["appointment"]);
            return ListTile(
              subtitle: Text(
                apt == -1
                    ? "None"
                    : "${data[apt].appointmentType}(${DateFormat("dd MMM yyy")
                    .format(DateTime.parse(data[apt].appointmentDate))}})",
              ),
              title: const Text("Appointment"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () =>
          const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      if (formState["mode"] == "event")
        asyncARTEvents.when(
          data: (data) {
            final event = data.indexWhere(
                    (element) => element.id == formState["event"]);

            return ListTile(
              subtitle: Text(
                event == -1
                    ? "None"
                    : "${data[event].title}(${DateFormat("dd MMM yyy").format(
                    DateTime.parse(data[event].distributionTime))})",
              ),
              title: const Text("Event"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () =>
          const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      if (formState["type"] == "other")
        asyncARTTreatmentSupport.when(
          data: (data) {
            final careReceiver = data.indexWhere(
                    (element) => element.careReceiver.cccNumber == formState["careReceiver"]);
            return ListTile(
              subtitle: Text(
                careReceiver == -1
                    ? "None"
                    : "${data[careReceiver].careReceiver.name}(${data[careReceiver].careReceiver.cccNumber})",
              ), title: const Text("Care receiver"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () =>
          const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ,
      if (formState["deliveryMethod"] == "in-parcel")
        asyncCourierServices.when(
          data: (data) {
            final courier = data.indexWhere(
                    (element) => element.id == formState["courierService"]);
            return ListTile(
              subtitle: Text(
                courier == -1
                    ? "None"
                    : data[courier].name,
              ),
              title: const Text("Courier service"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () =>
          const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ListTile(
        subtitle: Text(formState["deliveryMethod"] ?? "None"),
        title: const Text("Delivery preference"),
        leading: const Icon(Icons.check),
      ),
      if (formState["deliveryMethod"] == "in-person")
        ExpansionTile(
          title: const Text("Delivery Person"),
          leading: const Icon(Icons.check),
          subtitle: Text(formState["deliveryPersonFullName"] ?? "None"),
          children: [
            ListTile(
              subtitle: Text(formState["deliveryPersonNationalId"] ?? "None"),
              title: const Text("National Id"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
            ListTile(
              subtitle: Text(formState["deliveryPersonPhoneNumber"] ?? "None"),
              title: const Text("contact"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
            ListTile(
              subtitle: Text(formState["pickupTime"] == null ? "None":  DateFormat("dd MMM yyy HH:mm a")
                  .format(DateTime.parse(formState["pickupTime"]))),
              title: const Text("Pickup time"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
          ],
        ),
      ListTile(
        subtitle: Text(formState["phoneNumber"] ?? "None"),
        title: const Text("Phone number"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["deliveryAddress"]?["address"] ?? "None"),
        title: const Text("Delivery location"),
        leading: const Icon(Icons.check),
      ),
    ]);
  }
}
