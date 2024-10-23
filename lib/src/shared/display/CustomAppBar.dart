import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../utils/helpers.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final Color? color;
  final Widget? bottom;
  final double? height;
  final String? smallTitle;
  final String? rightBtTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.bottom,
    this.color,
    this.height,
    this.smallTitle,
    this.rightBtTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      width: double.infinity, // Use double.infinity for responsive width
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.SPACING,
        vertical: Constants.SPACING * 3,
      ),
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.primary,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    "assets/images/reply.svg",
                    semanticsLabel: "Back",
                    fit: BoxFit.contain,
                    width: 25,
                    height: 25,
                  ),
                  onTap: () => context.pop(),
                ),
                if (smallTitle != null)
                  Text(
                    smallTitle ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                if (rightBtTitle != null)
                  TextButton(
                    onPressed: (){

                       },
                      child: Text(rightBtTitle??'', style: theme.textTheme.titleSmall!.copyWith(color: Constants.bgColor),)
                  // Container(
                  //   height: 10,
                  //   width: 150,
                  //   child: Button(
                  //     backgroundColor: color,
                  //     textColor: Constants.bgColor,
                  //     title: rightBtTitle ?? '',
                  //     onPress: () {
                  //       // Add your onPress logic here
                  //     },
                  //   ),
                  )
              ],
          ),
          if (title != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Constants.SPACING),
                Text(
                  title ?? '',
                  style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(width: Constants.SPACING),
                if (icon != null)
                  Icon(
                    icon,
                    color: theme.canvasColor,
                  ),
              ],
            ),
          if (subTitle != null)
            const SizedBox(height: Constants.SPACING * 2),
          if (subTitle != null)
            Text(
              subTitle!,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          // if (bottom != null)
          //   const SizedBox(height: Constants.SPACING * 2),
          //   bottom!,
        ],
      ),
    );
  }
}
