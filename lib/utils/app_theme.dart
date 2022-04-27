import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final lightThemeData = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF4E3C5),
    primaryColor: const Color(0xffc76947),
    textTheme: TextTheme(
      bodyText2: GoogleFonts.lora(
        color: const Color(0xff0c1736),
      ),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xffc76947),
        elevation: 1,
        foregroundColor: Color(0xff0c1736)),
  );
  static final darkThemeData = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyText2: GoogleFonts.lora(
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff544F63),
      elevation: 1,
    ),
  );
}
