import 'package:flutter/material.dart';
import 'package:nishauri/src/features/common/presentation/helpers/constants.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greeting2.dart';
import 'package:nishauri/src/utils/constants.dart';

class Homescreen2 extends StatelessWidget {
  const Homescreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Greetings2(name: "Omosh"),
            Expanded(
              // Wrap the GridView.builder with Expanded
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: menuOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(Constants.SPACING),
                    padding: const EdgeInsets.all(Constants.SPACING),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Constants.ROUNDNESS * 10),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            iconSize: 50,
                            color: theme.colorScheme.onPrimary,
                            icon: Icon(menuOptions[index].icon),
                          ),
                        ),
                        Text(
                          menuOptions[index].title ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
