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
import 'package:nishauri/src/features/hiv/presentation/pages/HIVMenu.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/ProgrameRegistration.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileScreen.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileWizardFormScreen.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PrivacySettingsScreen.dart';
import 'package:nishauri/src/utils/routes.dart';

final routesProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final settingsState = ref.watch(settingsNotifierProvider);
  return GoRouter(
    initialLocation: "/",
    // redirect: (BuildContext context, GoRouterState state) async {
    //   bool requirePinAuth() =>
    //       authState.value?.isNotEmpty == true &&
    //       settingsState.isPrivacyEnabled &&
    //       !settingsState.isAuthenticated;
    //   return requirePinAuth() ? '/unlock?next=${state.path}' : null;
    // },
    routes: [
      GoRoute(
        name: RouteNames.ROOT,
        path: "/",
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
    name: RouteNames.VERIFY_ACCOUNT,
    path: 'account-verify',
    builder: (BuildContext context, GoRouterState state) {
      return const VerificationScreen();
    },
  ),
  GoRoute(
    name: RouteNames.UNLOCK_SCREEN,
    path: 'unlock',
    builder: (BuildContext context, GoRouterState state) {
      return const PinAuthScreen();
    },
  ),
  GoRoute(
    name: RouteNames.CHANGE_PASSWORD,
    path: 'change-password',
    builder: (BuildContext context, GoRouterState state) {
      return const ChangePassword();
    },
  ),
  GoRoute(
    name: RouteNames.BMI_CALCULATOR,
    path: 'bmi-calculator',
    builder: (BuildContext context, GoRouterState state) {
      return const BMICalculatorScreen();
    },
  ),
  GoRoute(
    name: RouteNames.PRIVACY_SETTINGS,
    path: 'privacy-settings',
    builder: (BuildContext context, GoRouterState state) {
      return const PrivacySettingsScreen();
    },
  ),
  GoRoute(
    name: RouteNames.PROFILE_SETTINGS,
    path: 'profile',
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileScreen();
    },
  ),
  GoRoute(
    name: RouteNames.PROFILE_EDIT_FORM,
    path: 'profile-edit',
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileWizardFormScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_PROGRAM,
    path: 'hiv-program',
    builder: (BuildContext context, GoRouterState state) {
      return const HIVMenuScreen();
    },
    routes: hivProgramRoutes
  ),
];
final List<RouteBase> openRoutes = [
  GoRoute(
    name: RouteNames.LOGIN_SCREEN,
    path: 'login',
    builder: (BuildContext context, GoRouterState state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
    name: RouteNames.REGISTER_SCREEN,
    path: "sign",
    builder: (BuildContext context, GoRouterState state) {
      return const RegistrationScreen();
    },
  ),
  GoRoute(
    name: RouteNames.RESET_PASSWORD_SCREEN,
    path: 'reset-password',
    builder: (context, state) => const ResetPasswordScreen(),
  ),
];

final List<RouteBase> hivProgramRoutes = [
  GoRoute(
    name: RouteNames.HIV_PROGRAM_VERIFICATION,
    path: 'hiv-verify',
    builder: (BuildContext context, GoRouterState state) {
      return const HIVProgramRegistration();
    },
  ),
];
