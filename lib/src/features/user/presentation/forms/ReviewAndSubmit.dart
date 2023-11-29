
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class ReviewAndSubmit extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ReviewAndSubmit({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return Placeholder();
    final formState= formKey.currentState!;
    return Wrap(children: [
      if (formState.value['image'] != null)
        ListTile(
          leading: ClipOval(
            child: Image.file(
              File.fromUri(Uri.parse(formState.value['image'])),
              fit: BoxFit.cover,
            ),
          ),
          title: const Text("Username"),
          subtitle: Text(formState.value['username']),
        ),
      ListTile(
        title: const Text("Full name"),
        subtitle: Text(
            "${formState.value['firstName']} ${formState.value['lastName']}"),
      ),
      if (formState.value['dateOfBirth'] != null)
        ListTile(
          title: const Text("Date of birth"),
          subtitle: Text(DateFormat("dd MMM yyyy")
              .format(DateTime.parse("${formState.value['dateOfBirth']}"))),
        ),
      ListTile(
        title: const Text("Gender"),
        subtitle: Text(formState.value['gender'] == "M" ? "Male" : "Female"),
      ),
      ListTile(
        title: const Text("Email"),
        subtitle: Text(formState.value['email']),
      ),
      ListTile(
        title: const Text("Phone number"),
        subtitle: Text(formState.value['phoneNumber']),
      ),
      Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text("Country"),
              subtitle: Text(formState.value['country']),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Constituency"),
              subtitle: Text(formState.value['constituency']),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("Blood Group"),
        subtitle: Text(formState.value['bloodGroup']),
      ),
      ListTile(
        title: const Text("Allergies"),
        subtitle: Text(formState.value['allergies'].isNotEmpty
            ? formState.value['allergies'].join(", ")
            : "None"),
      ),
      ListTile(
        title: const Text("Disabilities"),
        subtitle: Text(formState.value['disabilities'].isNotEmpty
            ? formState.value['disabilities'].join(", ")
            : "None"),
      ),
      ListTile(
        title: const Text("Chronic Illnesses"),
        subtitle: Text(formState.value['chronics'].isNotEmpty
            ? formState.value['chronics'].join(", ")
            : "None"),
      ),
      Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text("Weight"),
              subtitle: Text("${formState.value['weight']} kgs"),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Height"),
              subtitle: Text("${formState.value['height']} cm"),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("Marital status"),
        subtitle: Text(formState.value['maritalStatus']),
      ),
      ListTile(
        title: const Text("Primary language"),
        subtitle: Text(formState.value['primaryLanguage']),
      ),
      ListTile(
        title: const Text("Education level"),
        subtitle: Text(formState.value['educationLevel']),
      ),
      ListTile(
        title: const Text("Occupation"),
        subtitle: Text(formState.value['occupation']),
      ),
    ]);
  }
}
