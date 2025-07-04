// lib/utils/lucide_icons.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LucideCustomIcons {
  static Widget heartPulse({double size = 24, Color color = Colors.black}) =>
      SvgPicture.asset(
        'assets/icons/heart-pulse.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static Widget thermometer({double size = 24, Color color = Colors.black}) =>
      SvgPicture.asset(
        'assets/icons/thermometer.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static Widget droplet({double size = 24, Color color = Colors.black}) =>
      SvgPicture.asset(
        'assets/icons/droplet.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static Widget activitySquare(
          {double size = 24, Color color = Colors.black}) =>
      SvgPicture.asset(
        'assets/icons/activity-square.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
}
