import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF9C80E);
  static const Color secondaryColor = Color(0xFFE53935);
  static const Color backgroundColor = Color.fromRGBO(245, 245, 245, 1);
  static const Color blackcolor = Color(0xFF2B2D42);
  static const Color textgray = Color(0xFF6A6A6A);
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      useMaterial3: true,
      fontFamily: 'Inter',
    );
  }

  static TextStyle get lobsterTitle => GoogleFonts.lobster(
        color: Colors.white,
        fontSize: 50,
      );
}
