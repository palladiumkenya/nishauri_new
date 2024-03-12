import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/appointments/ARTAppointments.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/utils/routes.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  late Future<List<dynamic>> _upcomingAppointmentsFuture;
  late Future<List<dynamic>> _previousAppointmentsFuture;

  @override
  void initState() {
    super.initState();
    _upcomingAppointmentsFuture = _loadAppointments('assets/data/appointments.json');
    _previousAppointmentsFuture = _loadAppointments('assets/data/previous.json');
  }

  Future<List<dynamic>> _loadAppointments(String jsonPath) async {
    // Load appointments from JSON file
    String appointmentsJson = await rootBundle.loadString(jsonPath);
    Map<String, dynamic> appointmentsData = json.decode(appointmentsJson);
    List<dynamic> appointments = appointmentsData['data'];
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            _buildAppointmentsTab(_upcomingAppointmentsFuture),
            _buildAppointmentsTab(_previousAppointmentsFuture),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsTab(Future<List<dynamic>> futureAppointments) {
    return FutureBuilder(
      future: futureAppointments,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> appointments = snapshot.data ?? [];
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              // Customize the appearance of each appointment item
              var appointment = appointments[index];
              return ListTile(
                title: Text(appointment['appointment_type']),
                subtitle: Text(appointment['appointment_date']),
              );
            },
          );
        }
      },
    );
  }
}