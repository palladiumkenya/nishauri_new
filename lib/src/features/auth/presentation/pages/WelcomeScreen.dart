import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: Container(), //occupies all the unused space above
              ),
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  child: Logo(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Nishauri",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const Text(
                "Where Business Thrives: Biz-Boost,\n Your Growth Partner.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Let's you in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Button(
                title: "Login",
                onPress: () => context.go("/login"),
              ),
              const SizedBox(height: 20),
              Button(
                title: "Register",
                onPress: () => context.go("/register"),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
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
              const SizedBox(height: 40),
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
              const SizedBox(height: 20),
              Expanded(child: Container()),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
