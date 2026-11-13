/// Immutable domain models for the Holy Qur'an, Ayahs, Juz, and Reciters.
class Ayah {
  const Ayah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.translationEn,
    required this.transliteration,
    required this.tafsirNote,
  });

  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String translationEn;
  final String transliteration;
  final String tafsirNote;

  String get key => '$surahNumber:$ayahNumber';
}

class Surah {
  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.meaningEnglish,
    required this.revelationPlace,
    required this.ayahCount,
    required this.juzNumber,
    required this.ayahs,
  });

  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String meaningEnglish;
  final String revelationPlace;
  final int ayahCount;
  final int juzNumber;
  final List<Ayah> ayahs;
}

class Reciter {
  const Reciter({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.titleEn,
    required this.style,
    required this.surahCount,
    required this.accentHex,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String titleEn;
  final String style;
  final int surahCount;
  final int accentHex;

  String localizedName(bool isArabic) => isArabic ? nameAr : nameEn;
}
