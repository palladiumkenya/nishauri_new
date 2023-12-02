import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ReviewAndSubmit extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const ReviewAndSubmit({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    final theme = Theme.of(context);
    final formState = formKey.currentState?.fields ?? {};
    // return Placeholder();
    return Wrap(children: [
      ListTile(
        leading: AppAvatar(
            alt: Icon(Icons.person), image: formState["image"]?.value),
        title: const Text("Username"),
        subtitle: Text(formState['username']?.value ?? "None"),
      ),
      ListTile(
        title: const Text("Full name"),
        subtitle: Text(
            "${formState['firstName']?.value ?? "None"} ${formState['lastName']?.value ?? "None"}"),
      ),
      ListTile(
        title: const Text("Date of birth"),
        subtitle: Text(
          formState['dateOfBirth']?.value != null
              ? DateFormat("dd MMM yyyy")
                  .format(DateTime.parse("${formState['dateOfBirth']!.value}"))
              : "None",
        ),
      ),
      ListTile(
        title: const Text("Gender"),
        subtitle: Text(
          formState['gender']?.value != null
              ? (formState['gender']!.value == "M" ? "Male" : "Female")
              : "None",
        ),
      ),
      ListTile(
        title: const Text("Email"),
        subtitle: Text(
          formState['email']?.value != null
              ? formState['email']!.value
              : "None",
        ),
      ),
      ListTile(
        title: const Text("Phone number"),
        subtitle: Text(
          formState['phoneNumber']?.value ?? "None",
        ),
      ),
      Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text("Country"),
              subtitle: Text(formState['country']?.value ?? "None"),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Constituency"),
              subtitle: Text(formState['constituency']?.value ?? "None"),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("Blood Group"),
        subtitle: Text(
          formState['bloodGroup']?.value ?? "None",
        ),
      ),
        ListTile(
          title: const Text("Allergies"),
          subtitle: Text(formState['allergies']?.value?.isNotEmpty == true
              ? formState['allergies']?.value.join(", ")
              : "None"),
        ),
        ListTile(
          title: const Text("Disabilities"),
          subtitle: Text(formState['disabilities']?.value?.isNotEmpty == true
              ? formState['disabilities']?.value.join(", ")
              : "None"),
        ),
        ListTile(
          title: const Text("Chronic Illnesses"),
          subtitle: Text(formState['chronics']?.value?.isNotEmpty == true
              ? formState['chronics']?.value.join(", ")
              : "None"),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Weight"),
                subtitle: Text("${formState['weight']?.value ?? "None"} kgs"),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Height"),
                subtitle: Text("${formState['height']?.value ?? "None"} cm"),
              ),
            ),
          ],
        ),
        ListTile(
          title: const Text("Marital status"),
          subtitle: Text(formState['maritalStatus']?.value ?? "None"),
        ),
        ListTile(
          title: const Text("Primary language"),
          subtitle: Text(formState['primaryLanguage']?.value ?? 'None'),
        ),
      if (formState['educationLevel'] != null)
        ListTile(
          title: const Text("Education level"),
          subtitle: Text(formState['educationLevel']?.value ?? 'None'),
        ),
      if (formState['occupation'] != null)
        ListTile(
          title: const Text("Occupation"),
          subtitle: Text(formState['occupation']?.value ?? 'None'),
        ),
    ]);
  }
}
