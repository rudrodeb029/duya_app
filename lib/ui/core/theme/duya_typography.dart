import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography helper using Apple SF Pro on iOS/macOS and iPhone-proportioned
/// Inter (`SF Pro` equivalent) across Web/Windows/Android, paired with `Amiri`
/// for classical readable Qur'an & Dua Arabic script.
abstract final class DuyaTypography {
  static const List<String> _appleFontFallbacks = [
    '.AppleSystemUIFont',
    '-apple-system',
    'BlinkMacSystemFont',
    'SF Pro Text',
    'SF Pro Display',
  ];

  static String? resolvePrimaryFontFamily() {
    final interFamily = GoogleFonts.inter().fontFamily;
    final isAppleNative = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS);
    return isAppleNative ? '.AppleSystemUIFont' : interFamily;
  }

  static List<String> resolveFontFallbacks() {
    final interFamily = GoogleFonts.inter().fontFamily;
    return [
      ..._appleFontFallbacks,
      ?interFamily,
    ];
  }

  static TextTheme buildTextTheme(
    TextTheme base,
    Color primary,
    Color secondary,
  ) {
    final fontFamily = resolvePrimaryFontFamily();
    final fallbacks = resolveFontFallbacks();
    final themed = base.apply(
      fontFamily: fontFamily,
      fontFamilyFallback: fallbacks,
    );
    return themed.copyWith(
      displaySmall: themed.displaySmall?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        color: primary,
      ),
      headlineMedium: themed.headlineMedium?.copyWith(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: primary,
      ),
      headlineSmall: themed.headlineSmall?.copyWith(
        fontSize: 16.5,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: primary,
      ),
      titleLarge: themed.titleLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: primary,
      ),
      titleMedium: themed.titleMedium?.copyWith(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: primary,
      ),
      titleSmall: themed.titleSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.15,
        color: primary,
      ),
      bodyLarge: themed.bodyLarge?.copyWith(
        fontSize: 13,
        letterSpacing: -0.1,
        color: primary,
        height: 1.4,
      ),
      bodyMedium: themed.bodyMedium?.copyWith(
        fontSize: 11.5,
        letterSpacing: -0.08,
        color: secondary,
        height: 1.4,
      ),
      bodySmall: themed.bodySmall?.copyWith(
        fontSize: 10.5,
        letterSpacing: -0.05,
        color: secondary,
        height: 1.35,
      ),
      labelLarge: themed.labelLarge?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        color: primary,
      ),
      labelMedium: themed.labelMedium?.copyWith(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.05,
        color: primary,
      ),
      labelSmall: themed.labelSmall?.copyWith(
        fontSize: 9.5,
        fontWeight: FontWeight.w600,
        color: secondary,
      ),
    );
  }

  static TextStyle arabicScript({
    double fontSize = 21,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    double height = 1.9,
  }) {
    final amiriFamily = GoogleFonts.amiri().fontFamily;
    return TextStyle(
      fontFamily: amiriFamily,
      fontFamilyFallback: const ['.SF Arabic', 'Geeza Pro'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color,
    );
  }
}
