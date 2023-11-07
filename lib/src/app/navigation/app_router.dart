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
import 'package:nishauri/src/features/bmi/presentation/pages/BMICalculatorScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/MainScreen.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileScreen.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileWizardFormScreen.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PrivacySettingsScreen.dart';
import 'package:nishauri/src/utils/routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final settingsState = ref.watch(settingsNotifierProvider);

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
  final settingsState = ref.watch(settingsNotifierProvider);
  return GoRouter(
    initialLocation: RouteNames.ROOT,
    // redirect: (BuildContext context, GoRouterState state) async {
    //   bool requirePinAuth() =>
    //       authState.value?.isNotEmpty == true &&
    //       settingsState.isPrivacyEnabled &&
    //       !settingsState.isAuthenticated;
    //   return requirePinAuth() ? '/unlock?next=${state.path}' : null;
    // },
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
  ),
  GoRoute(
    path: RouteNames.UNLOCK_SCREEN.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const PinAuthScreen();
    },
  ),
  GoRoute(
    path: RouteNames.CHANGE_PASSWORD.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const ChangePassword();
    },
  ),
  GoRoute(
    path: RouteNames.BMI_CALCULATOR.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const BMICalculatorScreen();
    },
  ),
  GoRoute(
    path: RouteNames.PRIVACY_SETTINGS.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const PrivacySettingsScreen();
    },
  ),
  GoRoute(
    path: RouteNames.PROFILE_SETTINGS.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileScreen();
    },
  ),
  GoRoute(
    path: RouteNames.PROFILE_EDIT_FORM.substring(1),
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileWizardFormScreen();
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
