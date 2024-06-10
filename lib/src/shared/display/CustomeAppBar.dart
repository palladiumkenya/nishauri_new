import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../utils/helpers.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData? icon;
  final Color? color;
  final Widget? bottom;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.subTitle,
      this.icon,
      this.bottom,
      this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.SPACING, vertical: Constants.SPACING * 3),
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.primary,
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       color ?? theme.colorScheme.primary,
        //       theme.colorScheme.onSurface
        //     ]),
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
            child: SvgPicture.asset(
              "assets/images/reply.svg",
              semanticsLabel: "Doctors",
              fit: BoxFit.contain,
              width: 40,
              height: 40,
            ),
            onTap: () => context.pop(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(color: Colors.white),
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
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          if (bottom != null) const SizedBox(height: Constants.SPACING * 2),
          if (bottom != null) bottom!
        ],
      ),
    );
  }
}
