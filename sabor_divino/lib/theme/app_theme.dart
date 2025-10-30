import 'package:flutter/material.dart'; // <--- CORRIGIDO AQUI
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFC62828);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color textColor = Color(0xFF212121);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        scrolledUnderElevation: 2,
        iconTheme: const IconThemeData(color: textColor),
        titleTextStyle: GoogleFonts.poppins(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
            fontSize: 42, fontWeight: FontWeight.bold, color: textColor),
        headlineSmall: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w700, color: textColor),
        titleLarge: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
        bodyLarge: GoogleFonts.lato(fontSize: 16, color: textColor),
        bodyMedium: GoogleFonts.lato(fontSize: 14, color: Colors.grey[700]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: primaryColor,
        labelStyle:
        GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w500),
        secondaryLabelStyle:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      // CÓDIGO CORRETO
      cardTheme: CardThemeData( // <--- CORREÇÃO AQUI
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }
}