import 'package:flutter/material.dart';

import 'duya_colors.dart';
import 'duya_typography.dart';

/// Light (Warm Alabaster) & Warm Night (Celestial Slate) Material 3 themes.
abstract final class DuyaTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    const scheme = ColorScheme.light(
      primary: DuyaColors.emerald,
      onPrimary: Colors.white,
      secondary: DuyaColors.desertGold,
      onSecondary: DuyaColors.celestialNight,
      surface: DuyaColors.alabaster,
      onSurface: DuyaColors.textPrimaryLight,
      surfaceContainerHighest: DuyaColors.sandstone,
      outline: DuyaColors.borderLight,
      error: DuyaColors.error,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: DuyaColors.alabaster,
      textTheme: DuyaTypography.buildTextTheme(
        base.textTheme,
        DuyaColors.textPrimaryLight,
        DuyaColors.textSecondaryLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: DuyaColors.textPrimaryLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: DuyaColors.cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: DuyaColors.borderLight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuyaColors.emerald,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DuyaColors.emerald,
          side: const BorderSide(color: DuyaColors.emerald),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DuyaColors.sandstone,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    const scheme = ColorScheme.dark(
      primary: DuyaColors.emeraldBright,
      onPrimary: Colors.white,
      secondary: DuyaColors.desertGold,
      onSecondary: DuyaColors.celestialNight,
      surface: DuyaColors.nightCanvas,
      onSurface: DuyaColors.textPrimaryDark,
      surfaceContainerHighest: DuyaColors.nightSurface,
      outline: DuyaColors.nightBorder,
      error: DuyaColors.error,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: DuyaColors.nightCanvas,
      textTheme: DuyaTypography.buildTextTheme(
        base.textTheme,
        DuyaColors.textPrimaryDark,
        DuyaColors.textSecondaryDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: DuyaColors.textPrimaryDark,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: DuyaColors.nightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: DuyaColors.nightBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuyaColors.emeraldBright,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DuyaColors.nightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
