import 'package:flutter/material.dart';

// Het Galactic Funkadelic kleurenpalet
class GalacticColors {
  static const Color backgroundDark = Color(0xFF120A2A); // Diep space-paars
  static const Color surfaceCard = Color(0xFF1E143F); // Kaart-achtergrond
  static const Color primaryNeonPink = Color(0xFFFF2A85); // Neon roze/magenta
  static const Color accentNeonOrange = Color(0xFFFF8800); // Disco oranje
  static const Color accentCyan = Color(0xFF00F0FF); // Kosmisch cyaan
  static const Color textLight = Color(0xFFFFFFFF); // Wit voor leesbaarheid
  static const Color textMuted = Color(0xFFB8B2D1); // Zacht paars/grijs
}

// Het centrale thema voor de app
final ThemeData galacticFunkadelicTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: GalacticColors.backgroundDark,
  primaryColor: GalacticColors.primaryNeonPink,
  colorScheme: const ColorScheme.dark(
    primary: GalacticColors.primaryNeonPink,
    secondary: GalacticColors.accentNeonOrange,
    surface: GalacticColors.surfaceCard,
    onSurface: GalacticColors.textLight,
  ),

  // Grote knoppen voor gebruiksgemak
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: GalacticColors.primaryNeonPink,
      foregroundColor: GalacticColors.textLight,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  // Kaarten voor programma-items en voorzieningen
  cardTheme: CardThemeData(
    color: GalacticColors.surfaceCard,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  // Typografie met hoge leesbaarheid
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: GalacticColors.textLight,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: GalacticColors.textLight,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: GalacticColors.textLight,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: GalacticColors.textMuted,
    ),
  ),
);