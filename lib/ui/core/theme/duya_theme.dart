import 'package:flutter/material.dart';

import 'duya_colors.dart';
import 'duya_typography.dart';

/// Light (Warm Alabaster) & Warm Night (Celestial Slate) Material 3 themes.
abstract final class DuyaTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final fontFamily = DuyaTypography.resolvePrimaryFontFamily();
    final fontFallbacks = DuyaTypography.resolveFontFallbacks();
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
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: Colors.white,
        selectedColor: DuyaColors.emerald,
        secondarySelectedColor: DuyaColors.emerald,
        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontFamilyFallback: fontFallbacks,
          color: DuyaColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
        ),
        secondaryLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontFamilyFallback: fontFallbacks,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
        ),
        side: const BorderSide(color: DuyaColors.borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuyaColors.emerald,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DuyaColors.emerald,
          side: const BorderSide(color: DuyaColors.emerald),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DuyaColors.emerald,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.emerald, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final fontFamily = DuyaTypography.resolvePrimaryFontFamily();
    final fontFallbacks = DuyaTypography.resolveFontFallbacks();
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
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: DuyaColors.nightCard,
        selectedColor: DuyaColors.emeraldBright,
        secondarySelectedColor: DuyaColors.emeraldBright,
        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontFamilyFallback: fontFallbacks,
          color: DuyaColors.textPrimaryDark,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
        ),
        secondaryLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontFamilyFallback: fontFallbacks,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
        ),
        side: const BorderSide(color: DuyaColors.nightBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuyaColors.emeraldBright,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DuyaColors.emeraldBright,
          side: const BorderSide(color: DuyaColors.emeraldBright),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DuyaColors.emeraldBright,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontFamilyFallback: fontFallbacks,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DuyaColors.nightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.nightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.nightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DuyaColors.emeraldBright),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
