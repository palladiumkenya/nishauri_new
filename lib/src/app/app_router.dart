import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ChangePassword.dart';
import 'package:nishauri/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/RegistrationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ResetPasswordScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/SplashScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerificationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/WelcomeScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/HomeScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/MainScreen.dart';
import 'package:nishauri/src/utils/routes.dart';

final appRouterProvider = Provider<GoRouter>((ref)

{
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.ROOT,
    routes: [
      GoRoute(
        path: RouteNames.ROOT,
        builder: (context, state) => authState.when(
            data: (data) =>
                data.isNotEmpty ? const MainScreen() : const WelcomeScreen(),
            error: (error, _) => Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/warning.svg"),
                      Text(
                        "Could not Authenticate.\nCheck you network connection and try again\n${error.toString()}",
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            loading: () => const SplashScreen()),

      ),
      GoRoute(
        path: RouteNames.LOGIN_SCREEN,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.REGISTER_SCREEN,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: RouteNames.RESET_PASSWORD_SCREEN,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      // GoRoute(
      //   path: 'orders',
      //   builder: (context, state) => const OrdersScreen(),
      // ),
    ],
  );
});


final routesProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: RouteNames.ROOT,
    routes: [
      GoRoute(
        path: RouteNames.ROOT,
        builder: (BuildContext context, GoRouterState state) {
          return authState.when(data: (data) {
            return data.isNotEmpty ? const MainScreen() : const WelcomeScreen();
          }, error: (error, _) {
            return Center(
              child: Text(error.toString()),
            );
          }, loading: () {
            return const SplashScreen();
          });
        },
        routes: authState.value?.isNotEmpty == true ? secureRoutes : openRoutes,
      ),
    ],
  );
});
final List<RouteBase> secureRoutes = [
  GoRoute(
    path: RouteNames.VERIFY_ACCOUNT.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const VerificationScreen();
    },
  ), GoRoute(
    path: RouteNames.CHANGE_PASSWORD.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const ChangePassword();
    },
  ),
];
final List<RouteBase> openRoutes = [
  GoRoute(
    path: RouteNames.LOGIN_SCREEN.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
    path: RouteNames.REGISTER_SCREEN.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const RegistrationScreen();
    },
  ),
  GoRoute(
    path: RouteNames.RESET_PASSWORD_SCREEN.substring(1),
    builder: (context, state) => const ResetPasswordScreen(),
  ),
];

