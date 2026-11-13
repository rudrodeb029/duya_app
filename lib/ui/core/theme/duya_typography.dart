import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography helper combining modern geometric Latin (`Plus Jakarta Sans`)
/// with classical readable Arabic (`Amiri`) for Qur'an and Duas.
abstract final class DuyaTypography {
  static TextTheme buildTextTheme(
    TextTheme base,
    Color primary,
    Color secondary,
  ) {
    final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;
    final themed = base.apply(fontFamily: fontFamily);
    return themed.copyWith(
      displaySmall: themed.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        color: primary,
      ),
      headlineMedium: themed.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: primary,
      ),
      headlineSmall: themed.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: primary,
      ),
      titleLarge: themed.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      titleMedium: themed.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: themed.bodyLarge?.copyWith(
        color: primary,
        height: 1.45,
      ),
      bodyMedium: themed.bodyMedium?.copyWith(
        color: secondary,
        height: 1.45,
      ),
      labelLarge: themed.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: primary,
      ),
    );
  }

  static TextStyle arabicScript({
    double fontSize = 24,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    double height = 1.9,
  }) {
    final amiriFamily = GoogleFonts.amiri().fontFamily;
    return TextStyle(
      fontFamily: amiriFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color,
    );
  }
}
