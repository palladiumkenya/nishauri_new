import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/presentation/pages/AppointmentRescheduleScreen.dart';
import 'package:nishauri/src/features/appointments/presentation/pages/AppointmentsScreen.dart';
import 'package:nishauri/src/features/art/presentation/FacilityDirectory.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/auth/presentation/pages/UpdatePassword.dart';
import 'package:nishauri/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/RegistrationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ResetPasswordScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/SplashScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerificationScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerifiedResetPassword.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerifyResetPasswordScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/WelcomeScreen.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/presentation/pages/BloodSugarScreen.dart';
import 'package:nishauri/src/features/bmi/presentation/pages/BMICalculatorResultsScreen.dart';
import 'package:nishauri/src/features/bmi/presentation/pages/BMICalculatorScreen.dart';
import 'package:nishauri/src/features/bmi/presentation/pages/BMIHistoryScreen.dart';
import 'package:nishauri/src/features/bp/presentation/pages/bpMonitorScreen.dart';
import 'package:nishauri/src/features/chatbot/presentations/ChatScreen.dart';
import 'package:nishauri/src/features/clinic_card/presentation/pages/ClinicCardScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/FaqPage.dart';
import 'package:nishauri/src/features/common/presentation/pages/MainScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/SettingsScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/blog.dart';
import 'package:nishauri/src/features/confirm_delivery/presentation/pages/ConfirmDeliveryScreen.dart';
import 'package:nishauri/src/features/dashboard/presentation/pages/Dashboard.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/dawa_drop_menu.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/dawa_drop_screen.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/dispatched_drugs.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/program_appointments.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_drug.dart';
import 'package:nishauri/src/features/events_calendar/presentation/pages/EventsCalendar.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/ARTSites.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/HIVMenu.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/RegimenHistory.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/appointments/ARTAppointmentDetail.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/events/ARTEventDetail.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/events/ARTEventFormScreen.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/events/ARTEvents.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/groups/ARTGroupDetail.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/groups/ARTGroupFormScreen.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/groups/ARTGroups.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/DrugOrderWizardFormScreen.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/DrugOrders.dart';
import 'package:nishauri/src/features/lab/presentation/pages/LabResultsScreen.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/presentation/pages/ChatDetailScreen.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/presentation/pages/ChatUserList.dart';
import 'package:nishauri/src/features/nishauri_chat/chat/presentation/pages/ConversationList.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/editPeriodsScreen.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/logPeriods.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periodPlannerScreen.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periods_history.dart';
import 'package:nishauri/src/features/programs/presentation/pages/programs.dart';
import 'package:nishauri/src/features/provider/appointment_management/presentation/pages/reschedule_request_list.dart';
import 'package:nishauri/src/features/provider/dawa_drop_management/presentation/pages/dawa_drop_manager_screen.dart';
import 'package:nishauri/src/features/provider/presentation/pages/provider_main_Screen.dart';
import 'package:nishauri/src/features/provider/provider_registry/presentaion/pages/location_selection_screen.dart';
import 'package:nishauri/src/features/provider/provider_registry/presentaion/pages/provider_details.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/blood_pressure_posts.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/blood_sugar_posts.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/bpInsightScreen.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/bsInsightScreen.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/insight_screen.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/self_screening_menu.dart';
import 'package:nishauri/src/features/treatment_support/presentation/pages/TreatmentSupport.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileScreen.dart';
import 'package:nishauri/src/features/user/presentation/pages/ProfileWizardFormScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PrivacySettingsScreen.dart';
import 'package:nishauri/src/features/user_programs/presentation/pages/ProgramRegistrationScreen.dart';
import 'package:nishauri/src/features/user_programs/presentation/pages/ProgramUpdateScreen.dart';
import 'package:nishauri/src/features/user_programs/presentation/pages/ProgramVerificationScreen.dart';
import 'package:nishauri/src/features/visits/presentations/pages/FacilityVisitDetailScreen.dart';
import 'package:nishauri/src/features/visits/presentations/pages/FacilityVisitsScreen.dart';
import 'package:nishauri/src/utils/routes.dart';

final routesProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    // debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router.redirectLogic,
    routes: router.routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AuthState>>(
      authStateProvider,
      (_, __) => notifyListeners(),
    );
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final AsyncValue<AuthState> loginState_ = _ref.watch(authStateProvider);
    final areWeInOpenRoutes = state.matchedLocation.startsWith("/auth");
    // handle with loading loading
    if (loginState_.isLoading) return "/splash";

    // Handle with error
    if (loginState_.hasError && areWeInOpenRoutes) return null;
    if (loginState_.hasError && !areWeInOpenRoutes) return "/auth";
    // Handle with value
    final loginState = loginState_.requireValue;
    // Is user not logged in and accessing open route then let them be?
    if (!loginState.isAuthenticated && areWeInOpenRoutes) return null;
    // if not logged in and trying to accept secure root then redirect to login
    if (!loginState.isAuthenticated && !areWeInOpenRoutes) return "/auth";
    // If user already logged in and moving on open routes then redirect to home
    if (loginState.isAuthenticated == true && areWeInOpenRoutes) return '/';
    // If user is logged in bt not verified account the redirect to verification
    if (loginState.isAuthenticated && !loginState.isAccountVerified) {
      return '/account-verify';
    }
    // If user is logged in bt not completed profile account the redirect to profile update screen
    if (loginState.isAuthenticated && !loginState.isProfileComplete) {
      return '/profile-edit';
    }

    return null;
  }

  FutureOr<String?> _localRedirectLogic(
      BuildContext context, GoRouterState state) {
    return null;
  }

  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<String> getPhone() async {
    var phone = await _repository.getUserPhoneNumber();
    return phone;
  }

  List<GoRoute> get routes => [
        GoRoute(
          name: RouteNames.SPLASH_SCREEN,
          path: '/splash',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
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
        // GoRoute(
        //   name: RouteNames.VERIFY_ACCOUNT,
        //   path: '/account-verify',
        //   builder: (BuildContext context, GoRouterState state) {
        //     final extras = getPhone() as String;
        //     print("this is extras $extras");
        //     return VerificationScreen(username: extras);
        //   },
        // ),
        GoRoute(
          name: RouteNames.VERIFY_ACCOUNT,
          path: '/account-verify',
          builder: (BuildContext context, GoRouterState state) {
            return FutureBuilder<String>(
              future: getPhone(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final extras = snapshot.data!;
                  return VerificationScreen(username: extras);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            );
          },
        ),

        GoRoute(
          name: RouteNames.PROFILE_EDIT_FORM,
          path: '/profile-edit',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileWizardFormScreen();
          },
        ),
      ];
}

final List<RouteBase> secureRoutes = [
  GoRoute(
    name: RouteNames.EVENTS_CALENDAR,
    path: 'my-calendar',
    builder: (BuildContext context, GoRouterState state) {
      return const EventsCalendar();
    },
  ),
  GoRoute(
    name: RouteNames.Facility_Directory,
    path: 'Facility-directory',
    builder: (BuildContext context, GoRouterState state) {
      return const FacilityDirectoryScreen();
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
      return const UpdatePassword();
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
    name: RouteNames.SETTINGS,
    path: 'settings',
    builder: (BuildContext context, GoRouterState state) {
      return const SettingsScreen();
    },
  ),
  GoRoute(
      name: RouteNames.FAQs,
      path: 'faqs',
      builder: (BuildContext context, GoRouterState state) {
        return const FAQPage();
      }),
  GoRoute(
    name: RouteNames.PROFILE_SETTINGS,
    path: 'profile',
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileScreen();
    },
  ),
  GoRoute(
    name: RouteNames.BLOG_POST,
    path: 'blog',
    builder: (BuildContext context, GoRouterState state) {
      dynamic ann = state.extra;
      return BlogPostScreen(
        announcement: ann,
      );
    },
  ),
  GoRoute(
    name: RouteNames.PROGRAM_MENU,
    path: 'program-menu',
    builder: (BuildContext context, GoRouterState state) {
      return const ProgramsMenuScreen();
    },
    routes: programMenu,
  ),
  GoRoute(
    name: RouteNames.SELF_SCREENING,
    path: 'self-screening',
    builder: (BuildContext context, GoRouterState state) {
      return const SelfScreening();
    },
    routes: selfScreeningRoutes,
  ),
  GoRoute(
    name: RouteNames.DAWA_DROP_MENU,
    path: 'dawa-drop-menu',
    builder: (BuildContext context, GoRouterState state) {
      return const DawaDropMenuScreen();
    },
    routes: dawaDropRoutes,
  ),
  GoRoute(
    name: RouteNames.DASHBOARD,
    path: 'dashboard',
    builder: (BuildContext context, GoRouterState state) {
      return const Dashboard();
    },
  ),
  GoRoute(
    name: RouteNames.CHAT_HCW,
    path: 'chat-hcw',
    builder: (BuildContext context, GoRouterState state) {
      return const ChatHCWScreen();
    },
    routes: chatRoutes,
  ),
  GoRoute(
      name: RouteNames.APPOINTMENTS,
      path: 'appointments',
      builder: (BuildContext context, GoRouterState state) {
        return const AppointmentsScreen();
      },
      routes: [
        GoRoute(
          name: RouteNames.APPOINTMENTS_RESCHEDULE,
          path: 'reschedule',
          builder: (BuildContext context, GoRouterState state) {
            final payload = state.extra as AppointmentRescheduleScreenProps;

            return AppointmentRescheduleScreen(
              props: payload,
            );
          },
        ),
        GoRoute(
          name: RouteNames.HIV_ART_APPOINTMENT_DETAILS,
          path: "art-appointment",
          builder: (BuildContext context, GoRouterState state) {
            final extras = state.extra as Appointment;
            return ARTAppointmentDetailScreen(
              artAppointment: extras,
            );
          },
        ),
      ]),
  GoRoute(
    name: RouteNames.LAB_RESULTS,
    path: 'lab-results',
    builder: (BuildContext context, GoRouterState state) {
      return const LabResultsScreen();
    },
  ),
  GoRoute(
    name: RouteNames.MY_CLINIC_CARD,
    path: 'clinic-card',
    builder: (BuildContext context, GoRouterState state) {
      return const ClinicCardScreen();
    },
  ),
  GoRoute(
    name: RouteNames.DAWA_DROP,
    path: 'dawa-drop',
    builder: (BuildContext context, GoRouterState state) {
      return const DawaDropScreen();
    },
  ),
  GoRoute(
    name: RouteNames.CHAT_BOT,
    path: 'chat-bot',
    builder: (BuildContext context, GoRouterState state) {
      return const ChatScreen();
    },
  ),
  GoRoute(
    name: RouteNames.TREATMENT_SUPPORT,
    path: 'treatment-support',
    builder: (BuildContext context, GoRouterState state) {
      return const TreatmentSupport();
    },
  ),
  GoRoute(
      name: RouteNames.FACILITY_VISITS,
      path: 'facility-visits',
      builder: (BuildContext context, GoRouterState state) {
        return const FacilityVisitsScreen();
      },
      routes: [
        GoRoute(
          name: RouteNames.FACILITY_VISIT_DETAIL,
          path: ':visitId',
          builder: (BuildContext context, GoRouterState state) {
            return FacilityVisitDetailScreen(
                visitId: state.pathParameters["visitId"]!);
          },
        )
      ]),
  GoRoute(
    name: RouteNames.PROVIDER_MAIN_SCREEN,
    path: 'provider-main-screen',
    builder: (BuildContext context, GoRouterState state) {
      return const ProviderMainScreen();
    },
    routes: providerRoutes,
  ),
  GoRoute(
    name: RouteNames.LOCATION_SELECTION,
    path: 'location-selection',
    builder: (BuildContext context, GoRouterState state) {
      return LocationSelectionScreen();
    },
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
  GoRoute(
    name: RouteNames.VERIFY_RESET_PASSWORD_SCREEN,
    path: 'verify-reset-password',
    builder: (context, state) {
      final extras = state.extra as String;
      return ResetPasswordVerificationScreen(username: extras);
    },
  ),
  GoRoute(
    name: RouteNames.VERIFIED_RESET_PASSWORD_SCREEN,
    path: 'verified-reset-password',
    builder: (context, state) {
      final extras = state.extra as String;
      return VerifiedResetPassword(username: extras);
    },
  ),
];

final List<RouteBase> selfScreeningRoutes = [
  GoRoute(
      name: RouteNames.BMI_CALCULATOR,
      path: 'bmi-calculator',
      builder: (BuildContext context, GoRouterState state) {
        return const BMICalculatorScreen();
      },
      routes: [
        GoRoute(
            name: RouteNames.BMI_CALCULATOR_RESULTS,
            path: "bmi-calculator-results",
            builder: (BuildContext context, GoRouterState state) {
              double extra = state.extra! as double;
              return BMICalculatorResultsScreen(bmi: extra);
            }),
        GoRoute(
            name: RouteNames.BMI_HISTORY,
            path: "bmi-history",
            builder: (BuildContext context, GoRouterState state) {
              return BMIHistoryScreen();
            }),
      ]),
  GoRoute(
    name: RouteNames.BLOOD_PRESSURE,
    path: 'blood-pressure',
    builder: (BuildContext context, GoRouterState state) {
      return BPMonitorScreen();
    },
    routes: [
      GoRoute(
          name: RouteNames.BLOOD_PRESSURE_INSIGHT,
          path: 'blood-pressure-insight',
          builder: (BuildContext context, GoRouterState state) {
            return BsInsightScreen();
          },
          routes: [
            GoRoute(
              name: RouteNames.BLOOD_PRESSURE_POSTS,
              path: 'blood-pressure-posts',
              builder: (BuildContext context, GoRouterState state) {
                dynamic ann = state.extra;
                return BloodPressurePostScreen(announcement: ann,);
              },
            )
          ]
      ),
    ]
  ),
  GoRoute(
    name: RouteNames.BLOOD_SUGAR,
    path: 'blood-sugar',
    builder: (BuildContext context, GoRouterState state) {
      return BloodSugarScreen();
    },
    routes: [
      GoRoute(
        name: RouteNames.BLOOD_SUGAR_INSIGHT,
        path: 'blood-sugar-insight',
        builder: (BuildContext context, GoRouterState state) {
          return BsInsightScreen();
        },
        routes: [
          GoRoute(
              name: RouteNames.BLOOD_SUGAR_POSTS,
              path: 'blood-sugar-posts',
              builder: (BuildContext context, GoRouterState state) {
                dynamic ann = state.extra;
                return BloodSugarPostScreen(announcement: ann,);
              },
          )
        ]
      ),
    ]
  ),
  //Routes for the Period Planner
  GoRoute(
    name: RouteNames.PERIOD_PLANNER_SCREEN,
    path: 'period-planner-screen',
    builder: (BuildContext context, GoRouterState state) {
      return const PeriodPlannerScreen();
    },
    routes: [
      GoRoute(
        name: RouteNames.PERIOD_PLANNER_LOG_PERIODS,
        path: 'period-planner-log-period-calendar',
        builder: (BuildContext context, GoRouterState state) {
          return LogPeriodScreen();
        },
      ),
      GoRoute(
        name: RouteNames.PERIOD_PLANNER_PERIOD_HISTORY,
        path: 'period-planner-period-history',
        builder: (BuildContext context, GoRouterState state) {
          return const PeriodsHistory();
        },
        routes: [
          GoRoute(
            name: RouteNames.PERIOD_PLANNER_EDIT_PERIODS,
            path: 'period-planner-edit-periods',
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra as Map<String, dynamic>;
              final startDate = extra['startDate'] as DateTime;
              final endDate = extra['endDate'] as DateTime;
              final id = extra['id'] as int;
              return EditPeriods(
                initialStartDate: startDate,
                initialEndDate: endDate,
                cycleId: id,
              );
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
      name: RouteNames.INSIGHT,
      path: 'insight',
      builder: (BuildContext context, GoRouterState state) {
        return const InsightScreen();
      },
      routes: [
        GoRoute(
          name: RouteNames.BP_INSIGHT,
          path: 'bp-insight',
          builder: (BuildContext context, GoRouterState state) {
            return const BpInsightScreen();
          },
        ),
      ]),
];

final List<RouteBase> providerRoutes = [
  GoRoute(
    name: RouteNames.REQUEST_APP_RESCHEDULE,
    path: 'request-app-reschedule',
    builder: (BuildContext context, GoRouterState state) {
      return const RescheduleRequestListScreen();
    },
  ),
  GoRoute(
    name: RouteNames.DAWA_DROP_MANAGER,
    path: 'dawa-drop-manager',
    builder: (BuildContext context, GoRouterState state) {
      return const DawaDropManagemerScreen();
    },
  ),
  GoRoute(
    name: RouteNames.PROVIDER_DETAILS,
    path: 'provider-details',
    builder: (BuildContext context, GoRouterState state) {
      return const ProviderDetails();
    },
  ),
];
final List<RouteBase> hivProgramRoutes = [
  GoRoute(
    name: RouteNames.HIV_ART_SITES,
    path: 'art-sites',
    builder: (BuildContext context, GoRouterState state) {
      return const ARTSitesScreen();
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
      routes: [
        GoRoute(
          name: RouteNames.HIV_ART_GROUP_FORM,
          path: 'form',
          builder: (BuildContext context, GoRouterState state) {
            final extras = state.extra as ARTGroup?;
            return ARTGroupFormScreen(
              group: extras,
            );
          },
        ),
        GoRoute(
          name: RouteNames.HIV_ART_GROUP_DETAIL,
          path: ':id',
          builder: (BuildContext context, GoRouterState state) {
            return ARTGroupDetailScreen(
              groupId: state.pathParameters["id"]!,
            );
          },
        ),
      ]),
  GoRoute(
    name: RouteNames.HIV_ART_EVENTS,
    path: 'art-events',
    builder: (BuildContext context, GoRouterState state) {
      return const ARTEventsScreen();
    },
    routes: [
      GoRoute(
        name: RouteNames.HIV_ART_EVENT_FORM,
        path: 'form',
        builder: (BuildContext context, GoRouterState state) {
          final extras = state.extra as ARTEvent?;
          return ARTEventFormScreen(
            event: extras,
          );
        },
      ),
      GoRoute(
        name: RouteNames.HIV_ART_EVENT_DETAILS,
        path: ':id',
        builder: (BuildContext context, GoRouterState state) {
          return ARTEventDetailScreen(
            eventId: state.pathParameters["id"]!,
          );
        },
      ),
    ],
  ),
];

final List<RouteBase> dawaDropRoutes = [
  GoRoute(
      name: RouteNames.REQUEST_DRUGS,
      path: 'request-drugs',
      builder: (BuildContext context, GoRouterState state) {
        return RequestDrugMenuScreen();
      },
      routes: [
        GoRoute(
          name: RouteNames.PROGRAM_APPOINTMENT,
          path: 'program-appointment',
          builder: (BuildContext context, GoRouterState state) {
            return ProgramAppointmentsScreen();
          },
        ),
        GoRoute(
          name: RouteNames.HIV_ART_DELIVERY_REQUEST_FORM,
          path: "art-drug-request-form",
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>;
            final payload = extra["payload"];
            final type = extra["type"] as String?;
            if (payload is Appointment) {
              return DrugOrderWizardFormScreen(
                  artAppointment: payload, type: type);
            }
            if (payload is ARTEvent) {
              return DrugOrderWizardFormScreen(artEvent: payload, type: type);
            }
            return DrugOrderWizardFormScreen(type: type);
            return const DrugOrderWizardFormScreen();
          },
        ),
      ]),
  GoRoute(
    name: RouteNames.HIV_DRUG_ORDERS,
    path: 'drug-order',
    builder: (BuildContext context, GoRouterState state) {
      return const DrugOrdersScreen();
    },
  ),
  GoRoute(
      name: RouteNames.DISPATCHED_DRUGS,
      path: 'dispatched-drugs',
      builder: (BuildContext context, GoRouterState state) {
        return const DispatchedDrugs();
      },
      routes: [
        GoRoute(
            name: RouteNames.CONFIRM_DELIVERY,
            path: "confirm-delivery",
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra as Map<String, dynamic>;
              final orderId = extra["OrderId"] as int?;
              print(orderId);
              if (orderId == null) {
                throw "Order with this id was not found";
              } else {
                return ConfirmDeliveryScreen(orderId: orderId);
              }
            }),
      ]),
];

final List<RouteBase> chatRoutes = [
  GoRoute(
    name: RouteNames.CHAT_DETAIL,
    path: 'chat-detail',
    builder: (BuildContext context, GoRouterState state) {
      return ChatDetailScreen();
    },
  ),
  GoRoute(
    name: RouteNames.CHAT_USER,
    path: 'chat-user',
    builder: (BuildContext context, GoRouterState state) {
      return ChatUserListScreen();
    },
  ),
];
final List<RouteBase> programMenu = [
  GoRoute(
    name: RouteNames.PROGRAME_REGISTRATION_SCREEN,
    path: 'program-register',
    builder: (BuildContext context, GoRouterState state) {
      return const ProgramRegistrationScreen();
    },
    routes: [
      GoRoute(
        name: RouteNames.VERIFY_PROGRAM_OTP,
        path: 'verify',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra as Map<String, dynamic>;
          return ProgramVerificationScreen(payload: extra);
        },
      ),
    ],
  ),
  GoRoute(
    name: RouteNames.REMOVE_PROGRAM,
    path: 'remove-program',
    builder: (BuildContext context, GoRouterState state) {
      return const ProgramUpdateScreen();
    },
  ),
  GoRoute(
    name: RouteNames.HIV_PROGRAM,
    path: 'hiv-program',
    builder: (BuildContext context, GoRouterState state) {
      return const HIVMenuScreen();
    },
    routes: hivProgramRoutes,
  ),
];
