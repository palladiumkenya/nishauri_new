import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class Greetings extends StatelessWidget {
  final String? image;
  final String name;

  const Greetings({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final headerHeight = screenSize.height * 0.1;
    final radius = screenSize.width * 0.12;

    return Container(
      margin: EdgeInsets.only(bottom: headerHeight * 0.5),
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
            bottom: -(headerHeight * 0.5),
            height: headerHeight,
            width: screenSize.width * 0.75,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: headerHeight * 0.3,
                    child: image != null && image!.isNotEmpty
                        ? Image.network(image!)
                        : Text(name.substring(0, 1).toUpperCase()),
                  ),
                  const SizedBox(
                    width: Constants.SPACING,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hello 👋,",
                        ),
                        Text(
                          name,
                          style: const TextStyle(fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
