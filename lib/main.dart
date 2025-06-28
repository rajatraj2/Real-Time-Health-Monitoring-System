import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dih/profile_page.dart' as profile;
import 'package:dih/setting_screen.dart' as setting;
import 'package:dih/symptom_checker_screen.dart';
import 'package:dih/voice_command_screen.dart';
import 'package:dih/chatbot_screen.dart';
import 'package:dih/widgets/bottom_nav_bar.dart' as bottom_nav;
import 'package:dih/login_page.dart'; // ✅ Import your LoginPage

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIH Healthcare',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // ✅ System-based theme
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
      home: LoginPage(
          // isDarkMode: Theme.of(context).brightness == Brightness.dark,
          // toggleDarkMode: () {}, // TODO: Implement dark mode toggle logic
          ), // ✅ Show login first
      routes: {
        '/home': (context) => const bottom_nav.CustomBottomNavBar(),
        '/profile': (context) => const profile.ProfileScreen(),
        '/settings': (context) => const setting.SettingScreen(),
        '/symptom': (context) => const SymptomCheckerScreen(),
        '/voice': (context) => const VoiceCommandScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
      },
    );
  }
}
