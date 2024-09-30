import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class InsightCommon extends HookConsumerWidget {
  final String appBarTitle;
  final Color appBarColor;
  final AsyncValue<List<Announcement>> insightAsync;

  const InsightCommon({
    Key? key,
    required this.appBarTitle,
    required this.appBarColor,
    required this.insightAsync,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return insightAsync.when(
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
                title: appBarTitle,
                color: appBarColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final insight = data[index];
                    if (insight.id != "3") {
                      return Column(
                        children: [
                          const Divider(),
                          InkWell(
                            onTap: () {
                              context.goNamed(
                                RouteNames.BLOG_POST,
                                extra: insight,
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(Constants.SPACING),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Adjusted to use Flexible
                                    Flexible(
                                      child: SvgPicture.asset(
                                        insight.image,
                                        height: getOrientationAwareScreenSize(context).height * 0.05,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: Constants.SPACING),
                                    Expanded(
                                      child: Text(
                                        insight.title ?? '',
                                        style: theme.textTheme.titleSmall,
                                        overflow: TextOverflow.visible,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink(); // Return an empty widget if id == "3"
                    }
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
