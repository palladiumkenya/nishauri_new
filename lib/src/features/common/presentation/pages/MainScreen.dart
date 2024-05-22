import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/custom_icons.dart';
import 'package:nishauri/src/features/chatbot/presentations/ChatScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/HomeScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/MainMenuScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/SettingsScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/chat_feeback_form.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/features/user_preference/presentation/pages/PinAuthScreen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<MainScreen>
    with WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;
  AppLifecycleState state = AppLifecycleState.inactive;
  int _messagesCount = 0;
  int rebuild = 0;
  var _currIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleAppStatusChange();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
    handleAppStatusChange();
  }

  void handleAppStatusChange() {
    final settings = ref.watch(settingsNotifierProvider);
    // If app runs to background then set isAuthenticated to false
    if (state != AppLifecycleState.resumed && settings.isPrivacyEnabled) {
      ref
          .read(settingsNotifierProvider.notifier)
          .patchSettings(isAuthenticated: false);
    }
    // I user returns to foreground then show auth screen
    if (state == AppLifecycleState.resumed &&
        settings.isPrivacyEnabled &&
        !settings.isAuthenticated) showPinAuth(context);
  }

  void showPinAuth(BuildContext context) {
    // context.goNamed(RouteNames.UNLOCK_SCREEN);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          // Disable the default back button behavior
          return false;
        },
        child: PinAuthScreen(
          authenticate: (value) {
            final settings = ref.watch(settingsNotifierProvider);
            final settingsSetter = ref.read(settingsNotifierProvider.notifier);
            if (value != null && settings.pin == value) {
              if (settings.isAuthenticated == false) {
                context.pop();
                settingsSetter.patchSettings(isAuthenticated: true);
              }
            } else {
              return "Invalid pin";
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final pages = [
      const HomeScreen(),
      const MainMenuScreen(),
      ChatScreen(onChatsChange: (count) {
        setState(() {
          _messagesCount = count;
        });
      }),
      const SettingsScreen()
    ];

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _currIndex = 1;
      //     });
      //   },
      //   // child: const Icon(Icons.apps),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.disabledColor,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(Icons.apps),
            label: "Apps",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.comments),
            label: "Ask Nuru",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: "Settings",
          ),
        ],
        currentIndex: _currIndex,
        onTap: (index) async {
          if (_currIndex == 2 && index != 2 && _messagesCount > 2) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AlertDialog(
                content: ChatFeedbackForm(),
              ),
            );
          }
          setState(() {
            _currIndex = index;
            _messagesCount = 0;
          });
        },
      ),
      body: pages.elementAt(_currIndex),
    );
  }
}
