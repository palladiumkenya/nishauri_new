import 'package:flutter/material.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerificationScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/HomeScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/Homescreen2.dart';
import 'package:nishauri/src/features/common/presentation/pages/SettingsScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  var _currIndex = 0;
  final _pages = [
    const HomeScreen(),
    const Homescreen2(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _currIndex,
        onTap: (index) {
          setState(() {
            _currIndex = index;
          });
        },
      ),

      body: _pages.elementAt(_currIndex),
    );
  }
}
