import 'package:flutter/material.dart';
import 'package:dih/home_screen.dart';
import 'package:dih/symptom_checker_screen.dart';
import 'package:dih/chatbot_screen.dart';
import 'package:dih/profile_page.dart' as profile;

class CustomBottomNavBar extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const CustomBottomNavBar({
    super.key,
    required this.toggleDarkMode,
    required this.isDarkMode,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  int selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HealthDashboardScreen(
        isDarkMode: widget.isDarkMode,
        toggleDarkMode: widget.toggleDarkMode,
      ),
      const SymptomCheckerScreen(),
      const ChatBotScreen(),
      const profile.ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _screens[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing_outlined),
            label: 'Symptoms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_none_outlined),
            label: 'Voice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
