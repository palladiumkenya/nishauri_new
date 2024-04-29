import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class CustomTabBarItem {
  final String title;
  final IconData? icon;

  const CustomTabBarItem({required this.title, this.icon});
}

class CustomTabBar extends StatelessWidget {
  final List<CustomTabBarItem> items;
  final void Function(CustomTabBarItem item, int index) onTap;
  final Color? activeColor;
  final int? activeIndex;

  const CustomTabBar(
      {super.key,
      this.items = const [],
      required this.onTap,
      this.activeColor,
      this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(Constants.SPACING),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items
              .asMap()
              .entries
              .map(
                (e) => Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.ROUNDNESS * 10),
                  ),
                  child: InkWell(
                    onTap: () {
                      onTap(
                        e.value,
                        e.key,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal:Constants.SPACING,vertical: Constants.SPACING * 0.5),
                      decoration: BoxDecoration(
                          color: e.key == activeIndex
                              ? activeColor ?? theme.colorScheme.primary
                              : null),
                      child: Row(
                        children: [
                          if (e.value.icon != null)
                            Icon(
                              e.value.icon,
                              color: activeIndex == e.key ? Colors.white : null,
                            ),
                          if (e.value.icon != null)
                            const SizedBox(width: Constants.SPACING),
                          Text(
                            e.value.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: activeIndex == e.key ? Colors.white : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
