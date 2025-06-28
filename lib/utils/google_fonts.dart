import 'package:flutter/material.dart';

class GoogleFonts {
  static TextStyle poppins({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: 'Poppins', // Make sure this font is added in pubspec.yaml
    );
  }
}
