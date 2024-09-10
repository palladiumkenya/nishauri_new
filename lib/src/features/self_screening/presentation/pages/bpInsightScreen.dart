import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/self_screening/data/providers/insight_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class BpInsightScreen extends HookConsumerWidget {
  const BpInsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bpInsightAsync = ref.watch(insightProvider);

    return bpInsightAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return const BackgroundImageWidget(
            svgImage: "assets/images/appointments-empty.svg",
            notFoundText: "No Content",
          );
        }

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Blood Pressure Awhearness🌡️",
                color: Constants.bmiCalculatorColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final insight = data[index];
                    return Column(
                      children: [
                        const Divider(),
                        InkWell(
                          onTap: () {
                            context.goNamed(RouteNames.BLOG_POST, extra: insight);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(Constants.SPACING),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                       SvgPicture.asset(
                                        insight.image,
                                        width: double.infinity,
                                        height: getOrientationAwareScreenSize(context).height * 0.05,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: Constants.SPACING),
                                      Text(
                                        insight.title ?? '',
                                        style: theme.textTheme.titleSmall,
                                      ),
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
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        svgImage: 'assets/images/background.svg',
        notFoundText: error.toString(),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading insight content.",
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
