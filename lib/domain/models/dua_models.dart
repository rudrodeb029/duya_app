/// Immutable domain models for Duas, Athkar, and Tasbih repetition tracking.
class DuaCategory {
  const DuaCategory({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.iconName,
    required this.accentHex,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String iconName;
  final int accentHex;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}

class DuaItem {
  const DuaItem({
    required this.id,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
    required this.arabicText,
    required this.transliteration,
    required this.translationEn,
    required this.reference,
    required this.targetCount,
  });

  final String id;
  final String categoryId;
  final String titleEn;
  final String titleAr;
  final String arabicText;
  final String transliteration;
  final String translationEn;
  final String reference;
  final int targetCount;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}
