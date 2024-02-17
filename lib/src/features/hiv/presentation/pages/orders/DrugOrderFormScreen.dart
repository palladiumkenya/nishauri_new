import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';

class DrugOrderFormScreen extends StatelessWidget {
  final ARTAppointment? artAppointment;
  final ARTEvent? artEvent;

  const DrugOrderFormScreen({super.key, this.artAppointment, this.artEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Request home delivery"),
      ),
      body: const Placeholder(),
    );
  }
}
