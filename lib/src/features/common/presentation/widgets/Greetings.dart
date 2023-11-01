import 'package:flutter/material.dart';
import 'package:nishauri/src/features/common/presentation/helpers/constants.dart';
import 'package:nishauri/src/features/common/presentation/widgets/MenuOption.dart';
import 'package:nishauri/src/utils/constants.dart';

class Greetings extends StatelessWidget {
  final String? image;
  final String name;

  const Greetings({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final headerHeight = screenSize.height * 0.25;
    final radius = screenSize.width * 0.12;

    return Container(
      margin: EdgeInsets.only(bottom: headerHeight * 0.3),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: headerHeight,
            width: screenSize.width,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
          Positioned(
            bottom: -(headerHeight * 0.25),
            height: headerHeight * 1.25,
            width: screenSize.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello 👋,",
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20, color: theme.colorScheme.onPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(Constants.SPACING),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.SPACING * 2),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int currentIndex) {
                        return MenuOption(
                          title: menuOptions[currentIndex].title ?? "",
                          icon: menuOptions[currentIndex].icon,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
