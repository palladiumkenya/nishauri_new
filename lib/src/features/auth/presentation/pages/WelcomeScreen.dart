import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? bgCollor) => Container(
          padding: const EdgeInsets.all(Constants.SPACING * 4),
          decoration: BoxDecoration(
            color: bgCollor,
            borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Logo(),
              ),
              const SizedBox(height: Constants.SPACING),
              const Text(
                "Nishauri",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const Text(
                "Your Health, Your Priority: Start Today, \nThrive Tomorrow.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Constants.SPACING),
              const Text(
                "Let's you in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: Constants.SPACING),
              Button(
                title: "Login",
                onPress: () => context.go("/login"),
              ),
              const SizedBox(height: 20),
              Button(
                title: "Register",
                onPress: () => context.go("/register"),
              ),
              const SizedBox(height: Constants.SPACING),
              const SizedBox(height: Constants.SPACING),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 2,
                      color: Colors.black12,
                    ),
                  ),
                  const Text(
                    "Or continue with",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 2,
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Constants.SPACING),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                    ),
                  ),
                  const SizedBox(width: Constants.SPACING),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.apple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
