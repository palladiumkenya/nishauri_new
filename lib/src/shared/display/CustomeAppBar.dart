import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../utils/helpers.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CustomAppBar({super.key, required this.title, required this.subTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenSize = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.SPACING, vertical: Constants.SPACING * 3),
      height: screenSize.height * 0.22,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Constants.SPACING),
          bottomRight: Radius.circular(Constants.SPACING),
        ),
        image: const DecorationImage(
          image: AssetImage("assets/images/contours.png"),
          opacity: 0.1,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: Constants.SPACING),
          InkWell(
            child: Icon(Icons.arrow_back, color: theme.canvasColor),
            onTap: () => context.pop(),
          ),
          // IconButton(
          //   onPressed: () => context.pop(),
          //   icon: Icon(Icons.arrow_back, color: theme.canvasColor),
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineLarge
                    ?.copyWith(color: theme.canvasColor),
              ),
              const SizedBox(width: Constants.SPACING),
              Icon(icon, color: theme.canvasColor,)
            ],
          ),
          Text(
            subTitle,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.canvasColor),
          ),
        ],
      ),
    );
  }
}
