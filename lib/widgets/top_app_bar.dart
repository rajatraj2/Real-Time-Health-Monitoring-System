import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onIoTTap;
  final VoidCallback onSettingsTap;

  const CustomTopAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onIoTTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFE0F7FA),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.local_hospital, color: Colors.black);
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: onNotificationTap,
        ),
        IconButton(
          icon: const Icon(Icons.bluetooth_connected, color: Colors.black),
          onPressed: onIoTTap,
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
