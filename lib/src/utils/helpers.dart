import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

// Function to calculate BMI
double calculateBMI(
    double heightCm, int weightKgs) {
  return  weightKgs / ((heightCm/100) * (heightCm/100));
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

Future<String> loadJsonData(String path) async {
  final String data = await rootBundle.loadString(path);
  return data;
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

bool isNetworkUri(String uri) {
  final imageUri = Uri.parse(uri);
  final schemes = ['http', 'https', 'ftp', 'ftps'];
  return schemes.contains(imageUri.scheme);
}

void handleResponseError(
    BuildContext context,
    Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
        formState,
    err,
    void Function() onLogout) {
  switch (err) {
    case BadRequestException e:
      for (var err in e.errors.entries) {
        formState[err.key]?.invalidate(err.value);
      }
      break;
    case ResourceNotFoundException e:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
      break;
    case ForbiddenException e:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
      break;
    case UnauthorizedException e:
      onLogout();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
      break;
    case InternalServerErrorException e:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
  }
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(err.toString()),
  //   ),
  // );
}


Size getOrientationAwareScreenSize(BuildContext context) {
  final media = MediaQuery.of(context);
  final orientation = media.orientation;
  if(orientation == Orientation.portrait) {
    return media.size;
  }
  return Size(media.size.height, media.size.width);
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}