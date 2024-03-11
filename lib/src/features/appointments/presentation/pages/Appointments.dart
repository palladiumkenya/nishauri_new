import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/appointments/data/models/upcoming_appointment.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/appointments/ARTAppointments.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/features/appointments/data/providers/UpcomingAppointmentprovider.dart';
import 'package:nishauri/src/utils/routes.dart';

class Appointments extends ConsumerWidget {
  final List<dynamic> appointments;
  const Appointments(this.appointments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingAppointmentsAsyncValue =
        ref.watch(UpcomingAppointmentprovider);

    return upcomingAppointmentsAsyncValue.when(
      data: (List<Appointment> appointmentsData) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left),
            ),
            title: const Text("Appointments"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Upcoming Appointments"),
                Tab(text: "Previous Appointments"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildUpcomingAppointments(appointmentsData),
              const Center(child: Text("Previous Appointments")),
            ],
          ),
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildUpcomingAppointments(List<Appointment> appointmentsData) {
    if (appointmentsData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: appointmentsData.length,
        itemBuilder: (context, index) {
          final appointment = appointmentsData[index];
          return ListTile(
            title: Text("refill"),
            subtitle: Text("4-25-2024"),
            // Add other fields as needed
          );
        },
      );
    }
  }
}
