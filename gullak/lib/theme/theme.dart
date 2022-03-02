import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dark = ThemeData.from(
  colorScheme: const ColorScheme.dark().copyWith(
      secondary: const Color.fromRGBO(1, 217, 225, 1),
      primary: const Color.fromRGBO(13, 50, 82, 1)),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);

ThemeData light = ThemeData.from(
  colorScheme: const ColorScheme.light().copyWith(
      primary: const Color.fromRGBO(1, 217, 225, 1),
      secondary: const Color.fromRGBO(13, 50, 82, 1)),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
);
