import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ChangePassword.dart';
import 'package:nishauri/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/RegistrationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ResetPasswordScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerificationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/WelcomeScreen.dart';
import 'package:nishauri/src/features/bmi/presentation/pages/BMICalculatorScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/MainScreen.dart';
import 'package:nishauri/src/features/events_calendar/presentation/pages/EventsCalendar.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/ARTSites.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/HIVMenu.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/ProgrameRegistration.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/RegimenHistory.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/dashboard/HIVDashboard.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/events/ARTEvents.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/groups/ARTGroups.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/orders/HIVDrugOrders.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileScreen.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileWizardFormScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PrivacySettingsScreen.dart';
import 'package:nishauri/src/utils/routes.dart';

final routesProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router.redirectLogic,
    routes: router.routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<String>>(
      authStateProvider,
      (_, __) => notifyListeners(),
    );
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final loginState = _ref.watch(authStateProvider);
    if(loginState.isLoading || loginState.error != null) return "/auth/login";
    final areWeInOpenRoutes = state.matchedLocation.startsWith("/auth");
    // Is user not logged in?
    if (loginState.value?.isEmpty == true && areWeInOpenRoutes) return null;
    // if not logged in and trying to accept secure root then redirect to login
    if (loginState.value?.isEmpty == true && !areWeInOpenRoutes) return "/auth/login";
    // If user already logged in and moving on open routes then redirect to home
    if (loginState.value?.isNotEmpty == true && areWeInOpenRoutes) return '/';

    return null;
  }

  FutureOr<String?> _localRedirectLogic(
      BuildContext context, GoRouterState state) {
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          name: RouteNames.WELCOME_SCREEN,
          path: '/auth',
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeScreen();
          },
          routes: openRoutes,
        ),
        GoRoute(
          name: RouteNames.LANDING_SCREEN,
          path: '/',
          builder: (context, state) => const MainScreen(),
          routes: secureRoutes,
        ),
      ];
}

final List<RouteBase> secureRoutes = [
  GoRoute(
    name: RouteNames.VERIFY_ACCOUNT,
    path: 'account-verify',
    builder: (BuildContext context, GoRouterState state) {
      return const VerificationScreen();
    },
  ),GoRoute(
    name: RouteNames.EVENTS_CALENDAR,
    path: 'my-calendar',
    builder: (BuildContext context, GoRouterState state) {
      return const EventsCalendar();
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
      routes: hivProgramRoutes),
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
  GoRoute(
    name: RouteNames.HIV_DRUG_ORDERS,
    path: 'drug-order',
    builder: (BuildContext context, GoRouterState state) {
      return const HIVDrugOrdersScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_ART_SITES,
    path: 'art-sites',
    builder: (BuildContext context, GoRouterState state) {
      return const ARTSitesScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_DASHBOARD,
    path: 'dashboard',
    builder: (BuildContext context, GoRouterState state) {
      return const HIVDashboardScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_REGIMEN,
    path: 'regimen',
    builder: (BuildContext context, GoRouterState state) {
      return const RegimenHistoryScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_ART_GROUPS,
    path: 'art-groups',
    builder: (BuildContext context, GoRouterState state) {
      return const ARTGroupsScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_ART_EVENTS,
    path: 'art-events',
    builder: (BuildContext context, GoRouterState state) {
      return const ARTEventsScreen();
    },
  ),
];
