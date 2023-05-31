import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff0a0200),
    appBarTheme: const AppBarTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      selectedItemColor: Color(0xfff0f0f0),
      unselectedItemColor: Color(0xff001913),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color(0xff0a0200),
      primary: Color(0xfff0f0f0),
      secondary: Color.fromARGB(255, 28, 29, 29),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      titleMedium: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      bodySmall: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
    ));