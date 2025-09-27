import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final appThemeData = ThemeData(
    scaffoldBackgroundColor: Color(0xFFFFF9FB),

    textTheme: TextTheme(
      bodySmall: GoogleFonts.nunito(
        textStyle: const TextStyle(color: Colors.black),
      ),
      bodyMedium: GoogleFonts.montserrat(
        textStyle: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
