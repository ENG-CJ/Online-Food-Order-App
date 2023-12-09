import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_food_order_app/const/colors.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
        color: colors['primary'], fontWeight: FontWeight.bold, fontSize: 30),

    titleMedium: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold),

    titleSmall: GoogleFonts.poppins(color: Colors.black54, fontSize: 24),
    bodyMedium: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
    bodySmall: GoogleFonts.poppins(color: Colors.black, fontSize: 12),

    //?: Headline light
    headlineLarge:
        GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
    headlineMedium:
        GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
    headlineSmall:
        GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
  );


  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(color: Colors.white60, fontSize: 24),
    bodyLarge: GoogleFonts.poppins(color: Colors.black54, fontSize: 16),
    bodyMedium: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
    bodySmall: GoogleFonts.poppins(color: Colors.white, fontSize: 12),

    //?: Headline dark
    headlineLarge:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
    headlineMedium:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
    headlineSmall:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
    titleLarge:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
  );
}
