import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

/// Function to display the terms and conditions dialog.
///
/// This function fetches the terms and conditions content from a web URL
/// and displays it in a dialog.
///
/// [context] The build context.
void showTermsDialog(BuildContext context) async {
  // Fetch the terms and conditions content from the web URL
  final response = await http.get(Uri.parse('https://ushauriapi.nascop.org/terms'));

  // Check if the response status code is OK (200)
  if (response.statusCode == 200) {
    // Parse the HTML document
    final document = parser.parse(response.body);
    // Extract the terms content from the HTML document
    final termsContent = _extractTermsContent(document);

    // Show an AlertDialog with the terms and conditions content
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Terms and Conditions"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("By signing up, you agree to the following terms:"),
                const SizedBox(height: 8),
                // Display the extracted terms content
                Text(termsContent),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  } else {
    // Handle the case where the terms cannot be fetched
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Failed to load terms and conditions."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

/// Function to extract the terms content from the HTML document.
///
/// [document] The HTML document to extract the terms content from.
///
/// Returns the extracted terms content as a string.
String _extractTermsContent(dom.Document document) {
  final elements = document.querySelectorAll('body > p');
  final content = StringBuffer();

  for (final element in elements) {
    content.writeln(element.text.trim());
  }

  return content.toString();
}
