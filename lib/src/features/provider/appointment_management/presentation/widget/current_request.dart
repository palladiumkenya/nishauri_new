import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/provider/appointment_management/data/providers/appointment_management_provider.dart';
import 'package:nishauri/src/shared/dialog/dialog.dart';
import 'package:nishauri/src/shared/list_view_builder/list_view_builder.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class RescheduleRequestList extends HookConsumerWidget {
  final List<Appointment> appointments;

  const RescheduleRequestList({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final app = appointments[index];
                return RowViewList(
                  details: [
                    {"icon": Icons.account_circle_outlined, 'text': "Patient No: ${app.ccc_no ?? ''}"},
                    {'icon': Icons.date_range, 'text': "App Type: ${app.appointment_type ?? ''}"},
                    {'icon': Icons.calendar_month, 'text': "App Date: ${app.appointment_date ?? ''}"},
                    {'icon': Icons.date_range, 'text': "Reschedule Date: ${app.reschedule_date ?? ''}"},
                    {'icon': Icons.date_range, 'text': "Reason for reschedule: ${app.reschedule_reason ?? ''}"},
                    {'icon': Icons.build_circle_outlined, 'text': "Status: ${app.appt_status ?? ''}"},
                  ],
                  onRowTap: (index) {
                    HealthProgramDialog(
                        context,
                      "${app.ccc_no} from ${app.appointment_date} to ${app.reschedule_date}",
                          "Reschedule the Appointment for patient",
                      Constants.providerBgColor.withOpacity(0.5),
                      "Approve",
                      Constants.providerBgColor.withOpacity(0.2),
                      "Reject",
                      Constants.providerBgColor,
                          (){
                        print("Approving appointment reschedule");
                        ref.refresh(appointmentRescheduleProvider);
                      },
                        (){
                          print("Rejecting appointment reschedule");
                          ref.refresh(appointmentRescheduleProvider);
                        },
                    ).show();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
