/// Immutable domain models for the Daily Knowledge Challenge (8 Doors,
/// quiz questions, Ilm rewards, winners leaderboard, and FAQ support).
enum DoorTheme {
  prophet,
  quran,
  makkah,
  madinah,
  umrah,
  hajj,
  prayer,
  duas,
}

class ChallengeDoor {
  const ChallengeDoor({
    required this.id,
    required this.theme,
    required this.titleEn,
    required this.titleAr,
    required this.calligraphyAr,
    required this.subtitleEn,
    required this.colorHex,
    required this.imageAsset,
  });

  final String id;
  final DoorTheme theme;
  final String titleEn;
  final String titleAr;
  final String calligraphyAr;
  final String subtitleEn;
  final int colorHex;
  final String imageAsset;

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

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      doorId: json['doorId'] as String,
      questionEn: json['questionEn'] as String,
      optionsEn: List<String>.unmodifiable(
        (json['optionsEn'] as List<dynamic>).map((e) => e as String),
      ),
      correctIndex: json['correctIndex'] as int,
      explanationEn: json['explanationEn'] as String,
      reference: json['reference'] as String,
    );
  }

  final String id;
  final String doorId;
  final String questionEn;
  final List<String> optionsEn;
  final int correctIndex;
  final String explanationEn;
  final String reference;

  Map<String, dynamic> toJson() => {
        'id': id,
        'doorId': doorId,
        'questionEn': questionEn,
        'optionsEn': optionsEn,
        'correctIndex': correctIndex,
        'explanationEn': explanationEn,
        'reference': reference,
      };
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

class RaffleParticipant {
  const RaffleParticipant({
    required this.id,
    required this.displayName,
    required this.country,
    required this.ilmScore,
    required this.prizeTitle,
    this.isCurrentUser = false,
  });

  final String id;
  final String displayName;
  final String country;
  final double ilmScore;
  final String prizeTitle;
  final bool isCurrentUser;
}

class ChallengeFaq {
  const ChallengeFaq({required this.question, required this.answer});

  final String question;
  final String answer;
}
