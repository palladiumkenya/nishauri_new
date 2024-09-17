import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loginProvider.dart';  // Import the provider

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: loginState.when(
          data: (_) => ElevatedButton(
            onPressed: () {
              ref.read(loginProvider.notifier).login();  // Trigger login when button is pressed
            },
            child: const Text('Login'),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(loginProvider.notifier).login();  // Retry on error
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
