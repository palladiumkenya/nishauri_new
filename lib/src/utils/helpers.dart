import 'package:flutter/material.dart';

// Function to calculate BMI
double calculateBMI(
    String heightUnits, String weightUnits, double weight, double height) {
  double heightValue = height;
  double weightValue = weight;

  // Convert height and weight to standard units (meters and kilograms)
  if (heightUnits == 'cm') {
    heightValue /= 100;
  } else if (heightUnits == 'in') {
    heightValue *= 0.0254;
  } else if (heightUnits == 'ft') {
    heightValue *= 0.3048;
  }

  if (weightUnits == 'g') {
    weightValue /= 1000;
  } else if (weightUnits == 'lb') {
    weightValue *= 0.453592;
  }

  // Calculate BMI
  double bmi = weightValue / (heightValue * heightValue);
  return bmi;
}

String getBMIStatus(double bmi) {
  if (bmi < 18.5) {
    return "Underweight";
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return "Normal Weight";
  } else if (bmi >= 25.0 && bmi < 29.9) {
    return "Overweight";
  } else if (bmi >= 30.0 && bmi < 34.9) {
    return "Obese Class 1 (Moderate)";
  } else if (bmi >= 35.0 && bmi < 39.9) {
    return "Obese Class 2 (Severe)";
  } else {
    return "Obese Class 3 (Very Severe)";
  }
}

/*
1. Dependancy: flutter_local_auth

final FlutterLocalAuth _localAuth = FlutterLocalAuth();
bool isAuthenticated = false;

Future<void> showPinAuthentication() async {
  try {
    final authenticated = await _localAuth.authenticate(
      localizedReason: 'Authenticate with your PIN',
      useErrorDialogs: true, // Display system dialogs for PIN entry
      stickyAuth: true, // Keep the authentication alive in the app lifecycle
    );

    if (authenticated) {
      // User has been authenticated successfully
      setState(() {
        isAuthenticated = true;
      });
    } else {
      // Authentication failed
      // Handle this case accordingly
    }
  } on PlatformException catch (e) {
    // Handle errors (e.g., no biometric sensors found)
    print(e);
  }
}
*/
