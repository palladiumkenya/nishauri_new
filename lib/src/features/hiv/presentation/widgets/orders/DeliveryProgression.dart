import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';

class DeliverProgression extends StatefulWidget {
  final ARTDrugOrder order;

  const DeliverProgression({Key? key, required this.order}) : super(key: key);

  @override
  _DeliverProgressionState createState() => _DeliverProgressionState();
}

class _DeliverProgressionState extends State<DeliverProgression> {
  late int currentStep;
  late List<bool> stepIsActive;

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    // Initialize stepIsActive list with all steps inactive
    stepIsActive = List<bool>.filled(4, false);
    // Set active step based on order status
    updateActiveStep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Drug Delivery Progression Update"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Stepper(
          currentStep: currentStep,
          steps: [
            Step(
              title: const Text('Request Placed'),
              subtitle: const Text('We have received your drug request'),
              content: Text(''),
              isActive: stepIsActive[0],
            ),
            Step(
              title: const Text('Request Confirmed'),
              subtitle: const Text('Your request has been confirmed and is being processed'),
              content: Text(''),
              isActive: stepIsActive[1],
            ),
            Step(
              title: const Text('Request Processed'),
              subtitle: const Text('Order request has been dispatched'),
              content: Text(''),
              isActive: stepIsActive[2],
            ),
            Step(
              title: const Text('Order Received'),
              subtitle: const Text('Request has been received by the patient'),
              content: Text(''),
              state: StepState.complete,
              isActive: stepIsActive[3],
            ),
          ],
          type: StepperType.vertical,
          controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
            // Hide continue and cancel buttons by returning an empty widget
            return SizedBox.shrink();
          },
          onStepTapped: (step) {
            // Do nothing when tapping a step
          },
        ),
      ),
    );
  }

  void updateActiveStep() {
    final status = widget.order.status;
    if (status == 'Pending') {
      currentStep = 0;
    } else if (status == 'Approved') {
      currentStep = 1;
    } else if (status == 'Dispatched') {
      currentStep = 2;
    } else if (status == 'Received') {
      currentStep = 3;
    }
    // Set the corresponding step as active
    stepIsActive[currentStep] = true;
  }
}
