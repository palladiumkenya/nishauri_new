import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? selectedCounty;
  String? subCounty;
  final List<String> counties = [
    'County A',
    'County B',
    'County C',
    'County D',
  ];

  void submit() {
    if (selectedCounty != null && subCounty != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected County: $selectedCounty, Sub-County: $subCounty')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a county and enter a sub-county')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Select Location'),
      // ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: "Dawa Drop Requests 📋",
              color: Constants.providerBgColor,
            ),
            SizedBox(height: 10,),
            Text("Welcome admin", style: theme.textTheme.titleMedium,),
            SizedBox(height: 20),
            Text("Select your location from the list below.", style: theme.textTheme.bodyLarge,),
            SizedBox(height: 20),
            Text('Select a County:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCounty,
              hint: Text('Choose a county'),
              items: counties.map((String county) {
                return DropdownMenuItem<String>(
                  value: county,
                  child: Text(county),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCounty = newValue;
                  subCounty = null; // Reset sub-county when county changes
                });
              },
            ),
            SizedBox(height: 20),
            if (selectedCounty != null) ...[
              Text('Enter Sub-County:', style: TextStyle(fontSize: 18)),
              TextField(
                onChanged: (value) {
                  subCounty = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Sub-county name',
                ),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: Text('Submit'),
            ),
          ],
        ),
    );
  }
}
