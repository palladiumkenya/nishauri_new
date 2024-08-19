import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/utils/constants.dart';

class OnboardingStep extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final int index;

  const OnboardingStep(
      {super.key,
      required this.title,
      required this.icon,
      required this.description,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(Constants.SPACING * 3),
      child: Column(children: [
        const Spacer(),
        SvgPicture.asset(icon),
        const SizedBox(
          height: Constants.SPACING * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (index_) {
            final isActive = index == index_;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width * 0.12,
              height: Constants.SPACING * 1.5,
              decoration: BoxDecoration(
                color: isActive ?  theme.colorScheme.primary.withOpacity(0.5):  theme.disabledColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    Constants.ROUNDNESS,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: Constants.SPACING * 3,
        ),
        Text(title, style: theme.textTheme.headlineMedium),
        const SizedBox(
          height: Constants.SPACING * 3,
        ),
        Text(
          description,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ]),
    );
  }
}
