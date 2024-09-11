import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:intl/intl.dart'; // For formatting the date

import 'SelectSurvey.dart';




class SurveyScreen extends HookConsumerWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);


    // Hook to store the selected date
    final selectedDate = useState<DateTime?>(null);
    final TextEditingController dateController = useTextEditingController();

    // Function to show the date picker
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != selectedDate.value) {
        selectedDate.value = pickedDate;
        dateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate); // Formatting date
      }
    }



    return  Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Survey",
            // icon: Icons.calendar_month_outlined,
            subTitle: "Please ensure you complete the survey to the end",
            color: Constants.pSurveyColor,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Add padding inside the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Text asking for date input
                    const Text(
                      'Date of interview*:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // TextField for the date picker
                    TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true, // Prevent manual input
                      onTap: () => _selectDate(context), // Show date picker on tap
                    ),
                    const SizedBox(height: 20),

                    // Button to submit the date
                    SizedBox(
                      width: double.infinity, // Makes the button as wide as the parent container
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedDate.value != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Date submitted: ${DateFormat('yyyy-MM-dd').format(selectedDate.value!)}'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a date before submitting'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.pSurveyColor, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjusts button height to match TextField
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white), // Set button text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )





        ],
      ),
    );
  }
}