import 'package:flutter/material.dart';
import 'package:nishauri/src/features/auth/data/models/terms_and_conditions.dart';
import 'package:nishauri/src/features/auth/data/models/terms_conditions.dart';
import 'package:nishauri/src/features/auth/data/services/TermsConditionsService.dart';
import 'package:nishauri/src/utils/constants.dart';

Future<void> showTermsDialog(BuildContext context) async {
  final theme = Theme.of(context);
  final termsConditionsService = TermsConditionsService();
  TermsAndPrivacy? termsAndPrivacy;

  try {
    termsAndPrivacy = await termsConditionsService.termsCondition();
  } catch (e) {
    termsAndPrivacy = null;
  }

  if (termsAndPrivacy != null) {
    bool showPrivacyPolicy = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Terms and Conditions and Privacy Policy',
                  style: theme.textTheme.titleLarge),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(termsAndPrivacy?.termsConditions.title ?? 'Terms and Conditions',
                        style: theme.textTheme.titleLarge!.copyWith(decoration: TextDecoration
                            .underline,)),
                    const SizedBox(
                        height: Constants.SPACING),
                    Text(termsAndPrivacy?.termsConditions.introduction ?? ''),
                    ...?termsAndPrivacy?.termsConditions.sections!.map((section) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.header ?? '',
                              style: theme.textTheme.titleMedium),
                            ...section.content!.map((content) {
                              return Text(content);
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       showPrivacyPolicy = !showPrivacyPolicy;
                    //     });
                    //   },
                    //   child: Text(
                    //     'Show Privacy Policy',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),
                    // if (showPrivacyPolicy) ...[
                    const SizedBox(
                        height: Constants.SPACING),
                      Text(termsAndPrivacy?.privacyPolicy.title ?? 'Privacy Policy',
                          style: theme.textTheme.titleLarge!.copyWith(decoration: TextDecoration
                              .underline,)),
                    const SizedBox(
                        height: Constants.SPACING),
                      Text(termsAndPrivacy?.privacyPolicy.introduction ?? ''),
                      ...?termsAndPrivacy?.privacyPolicy.sections!.map((section) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.header ?? '',
                                style: theme.textTheme.titleMedium),
                              ...section.content!.map((content) {
                                return Text(content);
                              }).toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  // ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to load terms and conditions'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
