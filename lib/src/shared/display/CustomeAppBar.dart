import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../utils/helpers.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData icon;
  final Color? color;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.subTitle,
      required this.icon,
      this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.SPACING, vertical: Constants.SPACING * 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color ?? theme.colorScheme.primary,
              theme.colorScheme.onSurface
            ]),
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
        children: [
          const SizedBox(height: Constants.SPACING),
          InkWell(
            child: Icon(Icons.arrow_back, color: theme.canvasColor),
            onTap: () => context.pop(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineLarge
                    ?.copyWith(color: theme.canvasColor),
              ),
              const SizedBox(width: Constants.SPACING),
              Icon(
                icon,
                color: theme.canvasColor,
              )
            ],
          ),
          if (subTitle != null) const SizedBox(height: Constants.SPACING * 2),
          if (subTitle != null)
            Text(
              subTitle!,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.canvasColor),
            ),
        ],
      ),
    );
  }
}
