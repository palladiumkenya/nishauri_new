import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EbookModel.dart';
import 'EbookProvider.dart';

class FreeEbooks extends HookConsumerWidget {
  const FreeEbooks({Key? key}) : super(key: key);

  // Function to launch the URL and download
  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      // Launch the URL in the browser
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Handle the error, for example, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentAppointmentSync = ref.watch(appointmentProvider(false));
    final ebookAsyncValue = ref.watch(ebookProvider);
    return Scaffold(
      body: ebookAsyncValue.when(
        data: (ebooks) {
          return ListView.builder(
            itemCount: ebooks.length,
            itemBuilder: (context, index) {
              final ebook = ebooks[index];
              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    title: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.SPACING),  // You can adjust the padding as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title Text (Styled like program_name)
                            // Title and Download Icon Row
                            Row(
                              children: [
                                // Title Text
                                Expanded(
                                  child: Text(
                                    ebook.title,
                                    style: theme.textTheme.headline6,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                // Download Icon
                                const Icon(
                                  Icons.cloud_download_outlined,
                                  color: Colors.green,
                                ),
                              ],
                            ),

                            const SizedBox(height: Constants.SPACING),

                            // Invisible URL Row (Hidden from users)
                            Visibility(
                              visible: false,  // Hides the URL row but keeps it in the widget tree
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: Constants.SPACING),
                                  Text(ebook.url),
                                ],
                              ),
                            ),
                            // const SizedBox(height: Constants.SPACING),
                            //
                            // // Another Row (Styled like appointment_date)
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.cloud_download_outlined,
                            //       color: Colors.green,
                            //     ),
                            //     const SizedBox(width: Constants.SPACING),
                            //     Text("Tap to open or download"),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _launchUrl(context, ebook.url);  // Open URL on tap
                    },
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}