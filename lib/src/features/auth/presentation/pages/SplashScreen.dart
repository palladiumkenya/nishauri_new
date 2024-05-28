import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/Logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(child: Container()),
        const Logo(
          size: 100,
        ),
        const Text(
          "Nishauri",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
        Text(
          "Your Health, Your Priority: Start Today, \nThrive Tomorrow.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
        Expanded(child: Container()),
        CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    ));
  }
}
