import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfff0f0f0),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(color: Colors.black,iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xfff0f0f0),
      selectedItemColor: Color(0xff0a0200),
      unselectedItemColor: Color(0xfff0f0f0),
    ),
    colorScheme: const ColorScheme.light(
      background: Color(0xfff0f0f0),
      primary: Color(0xff0a0200),
      secondary: Color(0xfffbfcfe),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      titleMedium: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      bodySmall: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
    ));
