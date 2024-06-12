import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/utils/constants.dart';

enum CardVariant { FILLED, OUTLINED, ELEVETED }

class AppCard extends StatelessWidget {
  final CardVariant variant;
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehaviour;
  final Color? color;
  final String? svgImage;

  const AppCard({
    super.key,
    this.variant = CardVariant.FILLED,
    this.child,
    this.onTap,
    this.margin,
    this.clipBehaviour,
    this.color,
    this.svgImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget cardContent = child ?? Container();

    // Add the SVG background if provided
    if (svgImage != null) {
      cardContent = Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              svgImage!,
              fit: BoxFit.cover,
            ),
          ),
          if (child != null)
            Positioned.fill(
              child: child!,
            ),
        ],
      );
    }

    if (variant == CardVariant.OUTLINED) {
      return Card(
        color: color,
        clipBehavior: clipBehaviour,
        margin: margin,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Constants.ROUNDNESS)),
        ),
        child: InkWell(
          splashColor: theme.colorScheme.primary.withAlpha(30),
          onTap: onTap,
          child: cardContent,
        ),
      );
    } else if (variant == CardVariant.ELEVETED) {
      return Card(
        color: color,
        clipBehavior: clipBehaviour,
        margin: margin,
        child: InkWell(
          splashColor: theme.colorScheme.primary.withAlpha(30),
          onTap: onTap,
          child: cardContent,
        ),
      );
    } else {
      return Card(
        clipBehavior: clipBehaviour,
        margin: margin,
        elevation: 0,
        color: color ?? theme.colorScheme.surfaceVariant,
        child: InkWell(
          splashColor: theme.colorScheme.primary.withAlpha(30),
          onTap: onTap,
          child: cardContent,
        ),
      );
    }
  }
}
