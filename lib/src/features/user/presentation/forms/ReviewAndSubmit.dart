import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ReviewAndSubmit extends StatelessWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmit({super.key, required this.formState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return Placeholder();
    return Container(
      child: Wrap(children: [
        ListTile(
          leading: AppAvatar(alt: Icon(Icons.person), image: formState["image"]),
          title: const Text("Username"),
          subtitle: Text(formState['username'] ?? "None"),
        ),
        ListTile(
          title: const Text("Full name"),
          subtitle: Text(
              "${formState['firstName'] ?? "None"} ${formState['lastName'] ?? "None"}"),
        ),
        ListTile(
          title: const Text("Date of birth"),
          subtitle: Text(
            formState['dateOfBirth'] != null
                ? DateFormat("dd MMM yyyy")
                    .format(DateTime.parse("${formState['dateOfBirth']}"))
                : "None",
          ),
        ),
        ListTile(
          title: const Text("Gender"),
          subtitle: Text(
            formState['gender'] != null
                ? (formState['gender'] == "M" ? "Male" : "Female")
                : "None",
          ),
        ),
        ListTile(
          title: const Text("Email"),
          subtitle: Text(formState['email'] ?? "None"),
        ),
        ListTile(
          title: const Text("Phone number"),
          subtitle: Text(
            formState['phoneNumber'] ?? "None",
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Country"),
                subtitle: Text(
                  formState['country'] ?? "None",
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Constituency"),
                subtitle: Text(
                  formState['constituency'] ?? "None",
                ),
              ),
            ),
          ],
        ),
        // TODO Remove null checks
        if (formState['bloodGroup'] != null)
          ListTile(
            title: const Text("Blood Group"),
            subtitle: Text(formState['bloodGroup']),
          ),
        if (formState['allergies'] != null)
          ListTile(
            title: const Text("Allergies"),
            subtitle: Text(formState['allergies'].isNotEmpty
                ? formState['allergies'].join(", ")
                : "None"),
          ),
        if (formState['disabilities'] != null)
          ListTile(
            title: const Text("Disabilities"),
            subtitle: Text(formState['disabilities'].isNotEmpty
                ? formState['disabilities'].join(", ")
                : "None"),
          ),
        if (formState['chronics'] != null)
          ListTile(
            title: const Text("Chronic Illnesses"),
            subtitle: Text(formState['chronics'].isNotEmpty
                ? formState['chronics'].join(", ")
                : "None"),
          ),
        if (formState['weight'] != null)
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text("Weight"),
                  subtitle: Text("${formState['weight']} kgs"),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text("Height"),
                  subtitle: Text("${formState['height']} cm"),
                ),
              ),
            ],
          ),
        if (formState['maritalStatus'] != null)
          ListTile(
            title: const Text("Marital status"),
            subtitle: Text(formState['maritalStatus']),
          ),
        if (formState['primaryLanguage'] != null)
          ListTile(
            title: const Text("Primary language"),
            subtitle: Text(formState['primaryLanguage']),
          ),
        if (formState['educationLevel'] != null)
          ListTile(
            title: const Text("Education level"),
            subtitle: Text(formState['educationLevel']),
          ),
        if (formState['occupation'] != null)
          ListTile(
            title: const Text("Occupation"),
            subtitle: Text(formState['occupation']),
          ),
      ]),
    );
  }
}
