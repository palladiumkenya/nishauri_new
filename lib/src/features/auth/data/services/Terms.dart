import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
                // Display the extracted terms content using HtmlWidget
                HtmlWidget(termsContent),
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
  final content = StringBuffer();

  // Select all elements within the body of the HTML document
  final elements = document.querySelectorAll('body > *');

  for (final element in elements) {
    // // Check the tag name and apply appropriate formatting to the text content
    switch (element.localName) {
      case 'b':
      case 'strong':
        content.write('<b>${element.text.trim()}</b>');
        break;
      case 'i':
      case 'em':
        content.write('<i>${element.text.trim()}</i>');
        break;
      default:
        content.write(element.text.trim());
    }
  }

  return content.toString();
}
