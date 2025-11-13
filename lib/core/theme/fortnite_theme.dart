import 'package:flutter/material.dart';

class FortniteTheme {
  // Cores principais
  static const Color primaryPurple = Color(0xFF7b5cff);
  static const Color primaryBlue = Color(0xFF00d9ff);
  static const Color darkBackground = Color(0xFF0a0e27);
  static const Color cardBackground = Color(0xFF1a1f3a);
  static const Color darkCard = Color(0xFF151a2e);

  // Cores de raridade
  static const Color commonColor = Color(0xFF7f8c8d);
  static const Color uncommonColor = Color(0xFF2ecc71);
  static const Color rareColor = Color(0xFF3498db);
  static const Color epicColor = Color(0xFF9b59b6);
  static const Color legendaryColor = Color(0xFFf39c12);

  // Cores de texto
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFb0b3c1);

  static Color getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return commonColor;
      case 'uncommon':
        return uncommonColor;
      case 'rare':
        return rareColor;
      case 'epic':
        return epicColor;
      case 'legendary':
        return legendaryColor;
      default:
        return commonColor;
    }
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: primaryBlue,
        surface: cardBackground,
        error: Colors.redAccent,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: primaryBlue, blurRadius: 10)],
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: cardBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: textPrimary,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPurple, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryPurple.withAlpha(80), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary.withAlpha(190)),
        prefixIconColor: primaryPurple,
        suffixIconColor: primaryPurple,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: primaryPurple, blurRadius: 10)],
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: textPrimary,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: cardBackground,
        labelStyle: const TextStyle(color: textPrimary),
        secondaryLabelStyle: const TextStyle(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Dialog Theme
      dialogTheme: const DialogThemeData(
        backgroundColor: cardBackground,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Gradientes
  static LinearGradient get primaryGradient {
    return const LinearGradient(
      colors: [primaryPurple, primaryBlue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient get appBarGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        FortniteTheme.primaryPurple.withAlpha(80),
        FortniteTheme.primaryBlue.withAlpha(80),
      ],
    );
  }

  // Box Shadows
  static List<BoxShadow> get neonShadow {
    return [
      BoxShadow(
        color: primaryBlue.withAlpha(60),
        blurRadius: 1,
        spreadRadius: 2,
      ),
      BoxShadow(
        color: primaryPurple.withAlpha(60),
        blurRadius: 1,
        spreadRadius: -5,
      ),
    ];
  }

  static BoxShadow getRarityShadow(String rarity) {
    return BoxShadow(
      color: getRarityColor(rarity).withAlpha(100),
      blurRadius: 4,
      spreadRadius: 1,
    );
  }
}
