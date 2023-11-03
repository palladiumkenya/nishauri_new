import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/app_theme.dart';
import 'package:nishauri/src/app/navigation/app_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class NishauriApp extends ConsumerStatefulWidget {
  const NishauriApp({super.key});

  @override
  ConsumerState<NishauriApp> createState() => _NishauriAppState();
}

class _NishauriAppState extends ConsumerState<NishauriApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    handleAppStatusChange(AppLifecycleState.resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    handleAppStatusChange(state);
  }

  void handleAppStatusChange(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(settingsNotifierProvider.notifier).clearSettings();
        if (state == AppLifecycleState.resumed) {
          final settings = ref.watch(settingsNotifierProvider);
          final auth = ref.watch(authStateProvider);
          // Move the code that depends on inherited widgets/providers here.
          if (auth.value?.isNotEmpty == true && settings.isPrivacyEnabled) {
            print("======================>Here");
            showModalBottomSheet(
              isDismissible: false,
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(Constants.ROUNDNESS),
              //     topRight: Radius.circular(Constants.ROUNDNESS),
              //   ),
              // ),
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const FractionallySizedBox(
                  heightFactor: 1,
                  child: PinAuthScreen(),
                );
              },
            );
          }
        } else {
          ref
              .read(settingsNotifierProvider.notifier)
              .patchSettings(isPrivacyEnabled: false);
        }
      },
    );
  }

  //
  // Future<void> authenticateOnForeground() async {
  //   final isAvailable = await _localAuth.isDeviceSupported();
  //   if (isAvailable) {
  //     final isAuthenticated = await _localAuth.authenticate(
  //       localizedReason: 'Authenticate to access Nishauri',
  //     );
  //
  //     if (isAuthenticated) {
  //       // Authentication was successful
  //       // Proceed with your app logic
  //     } else {
  //       // Authentication failed
  //       // Navigate to PinAuthScreen for PIN authentication
  //       _router.go('/pin-auth'); // Replace with your actual route configuration
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routesProvider);
    // final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: "Nishauri",
      routerConfig: router,
      // routeInformationParser: GoRouterInformationParser(),
      // routeInformationProvider: PlatformRouteInformationProvider(
      //   initialRouteInformation: const RouteInformation(location: '/'),
      // ),
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
