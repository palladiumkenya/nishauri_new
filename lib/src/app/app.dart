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
    // handleAppStatusChange(AppLifecycleState.resumed);
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
    final settings = ref.watch(settingsNotifierProvider);
    final auth = ref.watch(authStateProvider);
    if (auth.value?.isNotEmpty == true && //Check if user is logged in
            settings.isPrivacyEnabled && // Check if user has enabled privacy
            state !=
                AppLifecycleState.resumed // Check if app is going in background
        ) {
      ref
          .read(settingsNotifierProvider.notifier)
          .patchSettings(isAuthenticated: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routesProvider);
    final settings = ref.watch(settingsNotifierProvider);
    final authState = ref.watch(authStateProvider);

    bool requirePinAuth() =>
        authState.value?.isNotEmpty == true &&
        settings.isPrivacyEnabled &&
        !settings.isAuthenticated;

    final screens = [
      const PinAuthScreen(),
      MaterialApp.router(
        title: "Nishauri",
        routerConfig: router,
        // routeInformationParser: GoRouterInformationParser(),
        // routeInformationProvider: PlatformRouteInformationProvider(
        //   initialRouteInformation: const RouteInformation(location: '/'),
        // ),
        theme: mainTheme,
        debugShowCheckedModeBanner: false,
      ),
    ];

    // final router = ref.watch(appRouterProvider);
    return Stack(
      children: requirePinAuth() ? screens.reversed.toList() : screens,
    );
  }
}
