import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProgramAppointmentsScreen extends ConsumerWidget {
  const ProgramAppointmentsScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appointmentAsync = ref.watch(appointmentProvider);

    return appointmentAsync.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left),
            ),
            title: const Text("Upcoming Appointments"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final appointment = data[index];
              return ListTile(
                leading: const Icon(Icons.calendar_month_sharp),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Program: ${appointment.program_name ?? ''}',
                   style: theme.textTheme.titleMedium?.merge(TextStyle(color: Colors.green)),),
                   Text(appointment.appointment_type ?? '',
                     style: theme.textTheme.titleSmall?.merge(TextStyle(color: Colors.grey)),),

                   Text(
                     DateFormat("dd MMM yyy").format(
                       DateFormat("EEEE, MMMM dd yyy").parse(
                         appointment.appointment_date,
                       ),
                     ),
                    style: theme.textTheme.titleSmall?.merge(TextStyle(color: Colors.grey)),
                   ),
                 ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.goNamed(
                    RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                    extra: appointment,
                  );
                },
              );
            },
          ),
        );
      },
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.toString(),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
          ],
        ),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Upcoming Appointments",
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
