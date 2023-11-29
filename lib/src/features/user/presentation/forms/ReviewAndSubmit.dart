import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class ReviewAndSubmit extends StatelessWidget {

  const ReviewAndSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Placeholder();
    /*return Wrap(children: [
      if (formState.values['image'] != null)
        ListTile(
          leading: ClipOval(
            child: Image.file(
              File.fromUri(Uri.parse(formState.values['image'])),
              fit: BoxFit.cover,
            ),
          ),
          title: const Text("Username"),
          subtitle: Text(formState.values['username']),
        ),
      ListTile(
        title: const Text("Full name"),
        subtitle: Text(
            "${formState.values['firstName']} ${formState.values['lastName']}"),
      ),
      if (formState.values['dateOfBirth'] != null)
        ListTile(
          title: const Text("Date of birth"),
          subtitle: Text(DateFormat("dd MMM yyyy")
              .format(DateTime.parse("${formState.values['dateOfBirth']}"))),
        ),
      ListTile(
        title: const Text("Gender"),
        subtitle: Text(formState.values['gender'] == "M" ? "Male" : "Female"),
      ),
      ListTile(
        title: const Text("Email"),
        subtitle: Text(formState.values['email']),
      ),
      ListTile(
        title: const Text("Phone number"),
        subtitle: Text(formState.values['phoneNumber']),
      ),
      Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text("Country"),
              subtitle: Text(formState.values['country']),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Constituency"),
              subtitle: Text(formState.values['constituency']),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("Blood Group"),
        subtitle: Text(formState.values['bloodGroup']),
      ),
      ListTile(
        title: const Text("Allergies"),
        subtitle: Text(formState.values['allergies'].isNotEmpty
            ? formState.values['allergies'].join(", ")
            : "None"),
      ),
      ListTile(
        title: const Text("Disabilities"),
        subtitle: Text(formState.values['disabilities'].isNotEmpty
            ? formState.values['disabilities'].join(", ")
            : "None"),
      ),
      ListTile(
        title: const Text("Chronic Illnesses"),
        subtitle: Text(formState.values['chronics'].isNotEmpty
            ? formState.values['chronics'].join(", ")
            : "None"),
      ),
      Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text("Weight"),
              subtitle: Text("${formState.values['weight']} kgs"),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Height"),
              subtitle: Text("${formState.values['height']} cm"),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("Marital status"),
        subtitle: Text(formState.values['maritalStatus']),
      ),
      ListTile(
        title: const Text("Primary language"),
        subtitle: Text(formState.values['primaryLanguage']),
      ),
      ListTile(
        title: const Text("Education level"),
        subtitle: Text(formState.values['educationLevel']),
      ),
      ListTile(
        title: const Text("Occupation"),
        subtitle: Text(formState.values['occupation']),
      ),
    ]);*/
  }
}
