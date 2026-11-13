import 'package:flutter/material.dart';

/// Original Duya brand & surface palette — distinct from any reference app.
abstract final class DuyaColors {
  // Brand Core
  static const Color emerald = Color(0xFF14634C);
  static const Color emeraldBright = Color(0xFF1F7D61);
  static const Color celestialNight = Color(0xFF155E49);
  static const Color celestialSlate = Color(0xFF217A60);
  static const Color desertGold = Color(0xFFC99A3B);
  static const Color desertGoldSoft = Color(0xFFF6EBD4);

  // Light Mode Surfaces
  static const Color alabaster = Color(0xFFF3F7F5);
  static const Color sandstone = Color(0xFFE9F0EC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE0EAE5);

  // Warm Night Surfaces
  static const Color nightCanvas = Color(0xFF1A2B24);
  static const Color nightSurface = Color(0xFF23382F);
  static const Color nightCard = Color(0xFF2C453B);
  static const Color nightBorder = Color(0xFF3E5C50);

  // Text
  static const Color textPrimaryLight = Color(0xFF263B33);
  static const Color textSecondaryLight = Color(0xFF5D7068);
  static const Color textPrimaryDark = Color(0xFFF2EFE9);
  static const Color textSecondaryDark = Color(0xFFA7B5AF);

  // Semantic
  static const Color success = Color(0xFF1B8A5A);
  static const Color successSoft = Color(0xFFE3F5EC);
  static const Color warning = Color(0xFFD9822B);
  static const Color warningSoft = Color(0xFFFCF0E1);
  static const Color error = Color(0xFFC23B3B);
  static const Color errorSoft = Color(0xFFFCE8E8);

  static const LinearGradient celestialHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, celestialSlate, Color(0xFF2F8F6E)],
  );

  static const LinearGradient emeraldGoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, Color(0xFF237D61), Color(0xFF7D6B36)],
  );
}
