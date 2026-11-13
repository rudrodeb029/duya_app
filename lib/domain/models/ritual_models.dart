/// Immutable domain models for Motawef ritual guidance, Haram permits,
/// live broadcasts, and Manasik educational articles.
enum MotawefPhase { ihram, tawaf, maqamIbrahim, zamzam, sai, tahallul }

class MotawefStep {
  const MotawefStep({
    required this.phase,
    required this.stepNumber,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.checklist,
    required this.duaArabic,
    required this.duaTransliteration,
    required this.duaTranslation,
    required this.hasLapCounter,
    required this.totalLaps,
  });

  final MotawefPhase phase;
  final int stepNumber;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final List<String> checklist;
  final String duaArabic;
  final String duaTransliteration;
  final String duaTranslation;
  final bool hasLapCounter;
  final int totalLaps;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}

class PermitSlot {
  const PermitSlot({
    required this.id,
    required this.type,
    required this.titleEn,
    required this.titleAr,
    required this.locationLabel,
    required this.dateLabel,
    required this.timeWindow,
    required this.availabilityLabel,
    required this.isAvailable,
  });

  final String id;
  final String type; // 'rawdah_men', 'rawdah_women', 'umrah'
  final String titleEn;
  final String titleAr;
  final String locationLabel;
  final String dateLabel;
  final String timeWindow;
  final String availabilityLabel;
  final bool isAvailable;
}

class PermitBooking {
  const PermitBooking({
    required this.id,
    required this.slot,
    required this.holderName,
    required this.permitCode,
    required this.status,
  });

  final String id;
  final PermitSlot slot;
  final String holderName;
  final String permitCode;
  final String status;
}

class LiveStreamChannel {
  const LiveStreamChannel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.mosqueName,
    required this.isLive,
    required this.khutbahSummary,
    required this.audioFallbackDuration,
    required this.reciterOrImam,
    required this.accentHex,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String mosqueName;
  final bool isLive;
  final String khutbahSummary;
  final String audioFallbackDuration;
  final String reciterOrImam;
  final int accentHex;
}

class RitualArticle {
  const RitualArticle({
    required this.id,
    required this.topic,
    required this.titleEn,
    required this.titleAr,
    required this.speakerOrAuthor,
    required this.durationOrReadTime,
    required this.mediaKind, // 'article', 'audio', 'video'
    required this.summary,
    required this.keyPoints,
  });

  final String id;
  final String topic; // 'Rituals', 'Hajj', 'Manasik', 'Reflections'
  final String titleEn;
  final String titleAr;
  final String speakerOrAuthor;
  final String durationOrReadTime;
  final String mediaKind;
  final String summary;
  final List<String> keyPoints;
}

class HaramServiceRequest {
  const HaramServiceRequest({
    required this.id,
    required this.serviceType, // 'Golf Cart', 'Wheelchair', 'Zamzam Station'
    required this.gateLocation,
    required this.timeWindow,
    required this.status,
  });

  final String id;
  final String serviceType;
  final String gateLocation;
  final String timeWindow;
  final String status;
}
