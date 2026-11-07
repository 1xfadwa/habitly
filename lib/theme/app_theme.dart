
import 'package:flutter/material.dart';

class AppTheme {
  // Light mode colors
  static const Color background = Color(0xFFF7F6F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF344E41);
  static const Color accent = Color(0xFFA3B18A);
  static const Color neutral = Color(0xFFDAD7CD);
  static const Color mutedText = Color(0xFF7B7B7B);

  // Dark mode colors
  static const Color darkBackground = Color(0xFF121A17);
  static const Color darkSurface = Color(0xFF1E2924);
  static const Color darkCard = Color(0xFF26352E);
  static const Color darkText = Color(0xFFF1F4EF);
  static const Color darkMutedText = Color(0xFFB7C2B8);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      surface: surface,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFDDE7D8),
      onPrimaryContainer: const Color(0xFF263B31),
      secondary: accent,
      onSecondary: const Color(0xFF263B31),
      surface: surface,
      onSurface: const Color(0xFF26332C),
      surfaceContainer: const Color(0xFFF0F0EA),
      surfaceContainerHighest: const Color(0xFFE9EAE3),
      onSurfaceVariant: mutedText,
      outline: const Color(0xFFB8BDB5),
      outlineVariant: neutral,
      error: const Color(0xFFBA1A1A),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: neutral,

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: primary,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
      surface: darkSurface,
    ).copyWith(
      primary: accent,
      onPrimary: const Color(0xFF1B261F),
      primaryContainer: const Color(0xFF344E41),
      onPrimaryContainer: const Color(0xFFE7EDE2),
      secondary: const Color(0xFFB8C69B),
      onSecondary: const Color(0xFF26332C),
      surface: darkSurface,
      onSurface: darkText,
      surfaceContainer: darkCard,
      surfaceContainerHighest: const Color(0xFF304038),
      onSurfaceVariant: darkMutedText,
      outline: const Color(0xFF718078),
      outlineVariant: const Color(0xFF43534A),
      error: const Color(0xFFFFB4AB),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkBackground,
      dividerColor: colorScheme.outlineVariant,

      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: accent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
