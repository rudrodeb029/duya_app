/// Immutable domain models for prayer times, locations, and Qibla calculations.
class PrayerLocation {
  const PrayerLocation({
    required this.id,
    required this.cityName,
    required this.cityNameAr,
    required this.countryName,
    required this.latitude,
    required this.longitude,
    required this.utcOffsetHours,
  });

  final String id;
  final String cityName;
  final String cityNameAr;
  final String countryName;
  final double latitude;
  final double longitude;
  final double utcOffsetHours;

  String localizedCity(bool isArabic) => isArabic ? cityNameAr : cityName;
}

enum PrayerName { fajr, sunrise, dhuhr, asr, maghrib, isha }

enum PrayerCalcMethod { ummAlQura, muslimWorldLeague, isna, egyptian, karachi }

class PrayerTimeEntry {
  const PrayerTimeEntry({
    required this.name,
    required this.titleEn,
    required this.titleAr,
    required this.time,
    required this.isNext,
    required this.notificationEnabled,
  });

  final PrayerName name;
  final String titleEn;
  final String titleAr;
  final DateTime time;
  final bool isNext;
  final bool notificationEnabled;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;

  PrayerTimeEntry copyWith({bool? isNext, bool? notificationEnabled}) {
    return PrayerTimeEntry(
      name: name,
      titleEn: titleEn,
      titleAr: titleAr,
      time: time,
      isNext: isNext ?? this.isNext,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }
}

class DailyPrayerSchedule {
  const DailyPrayerSchedule({
    required this.location,
    required this.date,
    required this.hijriLabel,
    required this.entries,
    required this.nextPrayer,
    required this.qiblaBearingDegrees,
    required this.distanceToKaabaKm,
    required this.method,
  });

  final PrayerLocation location;
  final DateTime date;
  final String hijriLabel;
  final List<PrayerTimeEntry> entries;
  final PrayerTimeEntry nextPrayer;
  final double qiblaBearingDegrees;
  final double distanceToKaabaKm;
  final PrayerCalcMethod method;
}
