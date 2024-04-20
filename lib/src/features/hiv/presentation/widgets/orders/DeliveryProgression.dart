import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/utils/routes.dart';

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
      floatingActionButton: widget.order.status == 'Dispatched'
          ? FloatingActionButton.extended(
        onPressed: () {
          context.goNamed(RouteNames.CONFIRM_DELIVERY,
              extra: {"OrderId": widget.order.order_id});
        },
        label: const Text("Confirm Delivery"),
        icon: const Icon(Icons.shopping_basket_outlined),
      )
          : null,
      body: Container(
        child: Stepper(
          currentStep: currentStep,
          steps: [
          Step(
          title: const Text('Request Placed'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('We have received your drug request'),
              Text('Date: ${widget.order.date_order_posted != null ? DateFormat('dd-MM-yyyy').format(widget.order.date_order_posted as DateTime) : ''}'),
            ],
          ),
          content: const Text('Your request has been received and is being reviewed'),
          isActive: stepIsActive[0],
        ),
            Step(
              title: const Text('Request Confirmed'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your request has been confirmed and is being processed'),
                  Text('Date: ${widget.order.approved_date != null ? DateFormat('dd-MM-yyyy').format(widget.order.approved_date as DateTime) : ''}'),
                ],
              ),
              content: Text(''),
              isActive: stepIsActive[1],
            ),
            Step(
              title: const Text('Request Processed'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order request has been dispatched'),
                  Text('Date: ${widget.order.dispatched_date != null ? DateFormat('dd-MM-yyyy').format(widget.order.dispatched_date as DateTime) : ''}'),
                ],
              ),
              content: Text(''),
              isActive: stepIsActive[2],
            ),
            Step(
              title: const Text('Order Received'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Request has been received by the patient'),
                  Text('Date: ${widget.order.fullfilled_date != null ? DateFormat('dd-MM-yyyy').format(widget.order.fullfilled_date as DateTime) : ''}'),
                ],
              ),
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
      stepIsActive[0] = true; // Set the corresponding step as active
    } else if (status == 'Approved') {
      currentStep = 1;
      stepIsActive[1] = true; // Set the corresponding step as active
    } else if (status == 'Dispatched') {
      currentStep = 2;
      stepIsActive[2] = true; // Set the corresponding step as active
    } else if (status == 'Fullfilled') {
      currentStep = 3;
      stepIsActive[3] = true; // Set the corresponding step as active
    }
  }
}
