import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class ProfileCard extends StatelessWidget {
  final double height;

  const ProfileCard({super.key, this.height = 300});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      child: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            // Cover photo
            width: double.maxFinite,
            // height: height,
            // decoration: BoxDecoration(color: theme.colorScheme.error),
            child: Column(children: [
              Container(
                height: height * 0.4,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://picsum.photos/200/300",
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Align(
            heightFactor: 1.6,
            child: CircleAvatar(
              radius: height * 0.25,
              child: const Icon(Icons.group),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Omondi Laurent Ouma",
              style: theme.textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }
}
