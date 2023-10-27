import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/app/app_router.dart';
import 'package:nishauri/src/app/app_theme.dart';
import 'package:nishauri/src/features/navigation/routes.dart';

class NishauriApp extends ConsumerWidget {
  const NishauriApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
