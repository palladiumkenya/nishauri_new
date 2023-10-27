import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    // referred from GREETINGS COMPONENTS
    final greeting = screenSize.height * 0.1;
    final headerHeight = screenSize.height - (greeting + greeting * 0.5);

    return Container(
      height: headerHeight * 0.3,
      // color: theme.primaryColor,
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Deals", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(
            height: Constants.SPACING,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, currIndex) => Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: screenSize.width * 0.7,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/p.jpg"),
                        fit: BoxFit.cover,
                      ),
                      backgroundBlendMode: BlendMode.darken,
                      color: theme.primaryColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Constants.SPACING))),
                  child: Center(
                    child: Text(
                      "Banner: ${currIndex + 1}",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
