import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_regimen_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class RegimenHistoryScreen extends ConsumerWidget {
  const RegimenHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final regimen = ref.watch(art_regimen_provider);
    return regimen.when(
      data: (data) {
        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "Regimen History",
                icon: Icons.local_hospital_outlined,
                color: theme.colorScheme.primary.withOpacity(0.8),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(),
                        ListTile(
                          title: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(Constants.SPACING),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CCC : ${data[index].ccc_no ?? ''}',
                                    style: theme.textTheme.headline6,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_hospital_rounded,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text('Regimen : ${data[index].regimen??''}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (data.isEmpty)
                Expanded(
                  child: BackgroundImageWidget(
                    svgImage: 'assets/images/background.svg',
                    notFoundText: "No Regimen Record Found",
                  ),
                ),
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        customAppBar: CustomAppBar(
          title: "Regimen History",
          icon: Icons.local_hospital_outlined,
          color: theme.colorScheme.primary.withOpacity(0.8),
        ),
        svgImage: 'assets/images/background.svg',
        notFoundText: error.toString(),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Regimen History",
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
