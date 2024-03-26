import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ARTAppointmentDetailScreen extends StatelessWidget {
  final ARTAppointment artAppointment;

  const ARTAppointmentDetailScreen({super.key, required this.artAppointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed(RouteNames.APPOINTMENTS),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Appointment Detail"),
      ),
      body: ListView(children: [
        const Divider(),
        const ListTile(
          leading: Icon(Icons.view_stream),
          title: Text("ART Program"),
          subtitle: Text("Program"),
          trailing: Icon(Icons.chevron_right),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.menu),
          title: Text(artAppointment.appointment_type??''),
          subtitle: const Text("Appointment type"),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.calendar_month_sharp),
          title: Text(
            DateFormat("dd MMM yyy").format(
              DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date),
            ),
          ),
          subtitle: const Text("Appointment date"),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.perm_identity),
          title: Text(artAppointment.ccc_no),
          subtitle: const Text("CCC Number"),
          trailing: const Icon(Icons.chevron_right),
        ),
        if (artAppointment.nextAppointmentDate != null) const Divider(),
        if (artAppointment.nextAppointmentDate != null)
          ListTile(
            leading: const Icon(Icons.perm_contact_calendar),
            title: Text(
              DateFormat("dd MMM yyy").format(
                DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date),
              ),
            ),
            subtitle: const Text("Next appointment date"),
            trailing: const Icon(Icons.chevron_right),
          ),
        if (artAppointment.appointment_type == "Re-Fill") const Divider(),
        if (artAppointment.appointment_type == "Re-Fill")
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Button(
              onPress: () {
                context.goNamed(RouteNames.HIV_ART_DELIVERY_REQUEST_FORM,
                    extra: {"payload": artAppointment, "type": "self"});
              },
              title: "Request Home delivery",
            ),
          )
      ]),
    );
  }
}
