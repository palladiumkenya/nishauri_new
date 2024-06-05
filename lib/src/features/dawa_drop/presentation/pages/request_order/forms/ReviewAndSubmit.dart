import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';

import '../../../../../orders/data/providers/courier_provider.dart';

class ReviewAndSubmit extends ConsumerWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmit({super.key, required this.formState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAppointments = ref.watch(appointmentProvider(false));
    // final asyncARTEvents = ref.watch(art_event_provider);
    // final asyncARTTreatmentSupport = ref.watch(artTreatmentSupportProvider);
    final asyncCourierServices = ref.watch(courierProvider);
    final theme = Theme.of(context);
    return Wrap(children: [
      ListTile(
        subtitle: Text(formState["mode"] ?? "None"),
        title: const Text("Mode"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["order_type"] ?? "None"),
        title: const Text("Type"),
        leading: const Icon(Icons.check),
      ),
      if (formState["mode"] == "Appointment")
        asyncAppointments.when(
          data: (data) {
            final apt = data.indexWhere(
                (element) => element.id == formState["appointment_id"]);
            return ListTile(
              subtitle: Text(
                apt == -1
                    ? "None"
                    : "${data[apt].appointment_type}(${DateFormat("dd MMM yyy").format(DateFormat('EEEE, MMMM d y').parse(data[apt].appointment_date))}})",
              ),
              title: const Text("Appointment"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      // if (formState["mode"] == "Event")
      //   asyncARTEvents.when(
      //     data: (data) {
      //       final event = data.indexWhere(
      //               (element) => element.id == formState["Event"]);
      //
      //       return ListTile(
      //         subtitle: Text(
      //           event == -1
      //               ? "None"
      //               : "${data[event].title}(${DateFormat("dd MMM yyy").format(
      //               DateTime.parse(data[event].distributionTime))})",
      //         ),
      //         title: const Text("Event"),
      //         leading: const Icon(Icons.check),
      //       );
      //     },
      //     error: (error, _) => Center(child: Text(error.toString())),
      //     loading: () =>
      //     const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   ),
      // if (formState["order_type"] == "other")
      //   asyncARTTreatmentSupport.when(
      //     data: (data) {
      //       final careReceiver = data.indexWhere(
      //               (element) => element.careReceiver.cccNumber == formState["careReceiver"]);
      //       return ListTile(
      //         subtitle: Text(
      //           careReceiver == -1
      //               ? "None"
      //               : "${data[careReceiver].careReceiver.name}(${data[careReceiver].careReceiver.cccNumber})",
      //         ), title: const Text("Care receiver"),
      //         leading: const Icon(Icons.check),
      //       );
      //     },
      //     error: (error, _) => Center(child: Text(error.toString())),
      //     loading: () =>
      //     const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   )
      // ,
      if (formState["delivery_method"] == "parcel")
        asyncCourierServices.when(
          data: (data) {
            final courier = data.indexWhere(
                (element) => element.id == formState["courier_service"]);
            return ListTile(
              subtitle: Text(
                courier == -1 ? "None" : data[courier].name ?? '',
              ),
              title: const Text("Courier service"),
              leading: const Icon(Icons.check),
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ListTile(
        subtitle: Text(formState["delivery_method"] ?? "None"),
        title: const Text("Delivery preference"),
        leading: const Icon(Icons.check),
      ),
      if (formState["delivery_method"] == "person")
        ExpansionTile(
          title: const Text("Delivery Person"),
          leading: const Icon(Icons.check),
          subtitle: Text(formState["delivery_person"] ?? "None"),
          children: [
            ListTile(
              subtitle: Text(formState["delivery_person_id"] ?? "None"),
              title: const Text("National Id"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
            ListTile(
              subtitle: Text(formState["delivery_person_contact"] ?? "None"),
              title: const Text("contact"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
            ListTile(
              subtitle: Text(formState["delivery_pickup_time"] == null
                  ? "None"
                  : DateFormat("dd MMM yyy HH:mm a").format(
                      DateTime.parse(formState["delivery_pickup_time"]))),
              title: const Text("Pickup time"),
              leading: const Icon(Icons.subdirectory_arrow_right),
            ),
          ],
        ),
      ListTile(
        subtitle: Text(formState["client_phone_no"] ?? "None"),
        title: const Text("Phone number"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["delivery_address"] ?? "None"),
        title: const Text("Delivery location"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["delivery_estate"] ?? "None"),
        title: const Text("Estate"),
        leading: const Icon(Icons.check),
      ),
      ListTile(
        subtitle: Text(formState["delivery_apartment"] ?? "None"),
        title: const Text("Apartment"),
        leading: const Icon(Icons.check),
      ),
    ]);
  }
}
