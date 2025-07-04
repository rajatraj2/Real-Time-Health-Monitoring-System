import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dih/auth/login_page.dart';
import 'package:dih/widgets/bottom_nav_bar.dart';
import 'package:dih/profile_page.dart';
import 'package:dih/setting_screen.dart';
import 'package:dih/symptom_checker_screen.dart';
import 'package:dih/chatbot_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Load .env file (must exist in root and be listed in pubspec.yaml)
  await dotenv.load(fileName: ".env");

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIH Healthcare',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      // ✅ Show login or home based on auth state
      home: FirebaseAuth.instance.currentUser != null
          ? CustomBottomNavBar(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
            )
          : const LoginPage(),

      // ✅ Define named routes
      routes: {
        '/home': (context) => CustomBottomNavBar(
              isDarkMode: _isDarkMode,
              toggleDarkMode: _toggleDarkMode,
            ),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingScreen(),
        '/symptom': (context) => const SymptomCheckerScreen(),
        '/chatbot': (context) => const ChatBotScreen(),
      },
    );
  }
}
