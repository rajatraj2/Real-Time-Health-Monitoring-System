import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onIoTTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onPdfTap;
  final VoidCallback onChatbotTap;
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;

  const CustomTopAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onIoTTap,
    required this.onSettingsTap,
    required this.onHistoryTap,
    required this.onPdfTap,
    required this.onChatbotTap,
    required this.toggleDarkMode,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFE0F7FA),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logu.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.local_hospital, color: Colors.black);
          },
        ),
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.history, color: Colors.black),
        //   onPressed: onHistoryTap,
        //   tooltip: 'Disease History',
        // ),
        // IconButton(
        //   icon: const Icon(Icons.picture_as_pdf, color: Colors.black),
        //   onPressed: onPdfTap,
        //   tooltip: 'Export to PDF',
        // ),
        // IconButton(
        //   icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
        //   onPressed: onChatbotTap,
        //   tooltip: 'Chatbot',
        // ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: onNotificationTap,
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: const Icon(Icons.bluetooth_connected, color: Colors.black),
          onPressed: onIoTTap,
          tooltip: 'IoT Connection',
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/setting.svg",
            height: 24,
            width: 24,
            placeholderBuilder: (context) =>
                const Icon(Icons.settings, color: Colors.black),
          ),
          onPressed: onSettingsTap,
          tooltip: 'Settings',
        ),
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
            color: isDarkMode ? Colors.orange : Colors.black,
          ),
          onPressed: toggleDarkMode,
          tooltip: 'Toggle Dark Mode',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
