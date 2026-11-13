/// Immutable domain models for the Daily Knowledge Challenge (4 Doors,
/// quiz questions, keys, winners leaderboard, and FAQ support).
enum DoorTheme { prophet, quran, makkah, madinah }

class ChallengeDoor {
  const ChallengeDoor({
    required this.id,
    required this.theme,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.colorHex,
  });

  final String id;
  final DoorTheme theme;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final int colorHex;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.doorId,
    required this.questionEn,
    required this.optionsEn,
    required this.correctIndex,
    required this.explanationEn,
    required this.reference,
  });

  final String id;
  final String doorId;
  final String questionEn;
  final List<String> optionsEn;
  final int correctIndex;
  final String explanationEn;
  final String reference;
}

class ChallengeWinner {
  const ChallengeWinner({
    required this.id,
    required this.displayName,
    required this.prizeTitle,
    required this.country,
    required this.isToday,
    required this.isSpotlight,
    required this.dateLabel,
  });

  final String id;
  final String displayName;
  final String prizeTitle;
  final String country;
  final bool isToday;
  final bool isSpotlight;
  final String dateLabel;
}

class ChallengeFaq {
  const ChallengeFaq({required this.question, required this.answer});

  final String question;
  final String answer;
}
