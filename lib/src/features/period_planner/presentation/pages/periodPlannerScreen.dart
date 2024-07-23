import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class PeriodPlannerScreen extends StatefulWidget {
  const PeriodPlannerScreen({super.key});

  @override
  State<PeriodPlannerScreen> createState() => _PeriodPlannerScreenState();
}

class _PeriodPlannerScreenState extends State<PeriodPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Period Planner 🌸",
            subTitle: "Track Your Cycle with Ease \nAnd Stay Informed",
            color: Constants.periodPlanner,
          ),
          const SizedBox(height: Constants.SPACING),
          const Text(
            'Saturday',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            '23',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Constants.SPACING),
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: Constants.SPACING * 30, // Adjust the width as needed
                height: Constants.SPACING * 30, // Adjust the height as needed
                child: CircularProgressIndicator(
                  value: 0.3, // example value for the progress
                  strokeWidth: 10,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Constants.periodPlanner),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Period Day 3',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Constants.SPACING + 20,), 
                  const Text(
                    'Low Chances of getting Pregnant',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: Constants.SPACING + 20,), 
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, 
                      backgroundColor: Constants.periodPlanner, // background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                    ),
                    child: const Text(
                      'Daily Log',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: Constants.SPACING),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add symptom log functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, 
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text(
                  'Symptoms',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add discharge log functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, 
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text(
                  'Discharge',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
