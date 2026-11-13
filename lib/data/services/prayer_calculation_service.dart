import 'dart:math' as math;

import 'package:adhan/adhan.dart';

import '../../domain/models/prayer_models.dart';

/// Computes astronomical prayer times, Qibla bearing, and Kaaba distance
/// offline via the `adhan` package.
class PrayerCalculationService {
  static const double _kaabaLat = 21.4225241;
  static const double _kaabaLng = 39.8261818;

  DailyPrayerSchedule computeSchedule({
    required PrayerLocation location,
    required DateTime now,
    required PrayerCalcMethod method,
    required Set<PrayerName> enabledAlerts,
  }) {
    final coordinates = Coordinates(location.latitude, location.longitude);
    final params = _toAdhanMethod(method).getParameters();
    final offset = Duration(
      minutes: (location.utcOffsetHours * 60).round(),
    );
    final dateComponents = DateComponents.from(now);
    final times = PrayerTimes(
      coordinates,
      dateComponents,
      params,
      utcOffset: offset,
    );

    final rawEntries = <({PrayerName name, String en, String ar, DateTime time})>[
      (name: PrayerName.fajr, en: 'Fajr', ar: 'الفجر', time: times.fajr),
      (name: PrayerName.sunrise, en: 'Sunrise', ar: 'الشروق', time: times.sunrise),
      (name: PrayerName.dhuhr, en: 'Dhuhr', ar: 'الظهر', time: times.dhuhr),
      (name: PrayerName.asr, en: 'Asr', ar: 'العصر', time: times.asr),
      (name: PrayerName.maghrib, en: 'Maghrib', ar: 'المغرب', time: times.maghrib),
      (name: PrayerName.isha, en: 'Isha', ar: 'العشاء', time: times.isha),
    ];

    final localCompare = now.toUtc().add(offset);
    var nextIndex = rawEntries.indexWhere((e) => e.time.isAfter(localCompare));
    if (nextIndex == -1) nextIndex = 0;

    final entries = List<PrayerTimeEntry>.generate(rawEntries.length, (i) {
      final item = rawEntries[i];
      return PrayerTimeEntry(
        name: item.name,
        titleEn: item.en,
        titleAr: item.ar,
        time: item.time,
        isNext: i == nextIndex,
        notificationEnabled: enabledAlerts.contains(item.name),
      );
    });

    final qibla = Qibla(coordinates);
    final distanceKm = _haversineKm(
      location.latitude,
      location.longitude,
      _kaabaLat,
      _kaabaLng,
    );

    return DailyPrayerSchedule(
      location: location,
      date: now,
      hijriLabel: _approximateHijriLabel(now),
      entries: entries,
      nextPrayer: entries[nextIndex],
      qiblaBearingDegrees: qibla.direction,
      distanceToKaabaKm: distanceKm,
      method: method,
    );
  }

  CalculationMethod _toAdhanMethod(PrayerCalcMethod method) {
    return switch (method) {
      PrayerCalcMethod.ummAlQura => CalculationMethod.umm_al_qura,
      PrayerCalcMethod.muslimWorldLeague => CalculationMethod.muslim_world_league,
      PrayerCalcMethod.isna => CalculationMethod.north_america,
      PrayerCalcMethod.egyptian => CalculationMethod.egyptian,
      PrayerCalcMethod.karachi => CalculationMethod.karachi,
    };
  }

  double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const earthRadiusKm = 6371.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) *
            math.cos(_degToRad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degToRad(double deg) => deg * (math.pi / 180.0);

  String _approximateHijriLabel(DateTime date) {
    const months = [
      'Muharram',
      'Safar',
      "Rabi' al-Awwal",
      "Rabi' al-Thani",
      'Jumada al-Ula',
      'Jumada al-Akhirah',
      'Rajab',
      "Sha'ban",
      'Ramadan',
      'Shawwal',
      "Dhu al-Qi'dah",
      'Dhu al-Hijjah',
    ];
    // Deterministic civil tabular Hijri approximation for offline display.
    final jd = (date.millisecondsSinceEpoch / 86400000.0) + 2440587.5;
    final l = (jd.floor() - 1948440) + 10632;
    final n = ((l - 1) / 10631).floor();
    final rem = l - 10631 * n + 354;
    final j = (((10985 - rem) / 5316).floor()) *
            (((50 * rem) / 17719).floor()) +
        ((rem / 5670).floor()) * (((43 * rem) / 15238).floor());
    final adjusted = rem -
        (((30 - j) / 15).floor()) * (((17719 * j) / 50).floor()) -
        ((j / 16).floor()) * (((15238 * j) / 43).floor()) +
        29;
    final month = ((24 * adjusted) / 709).floor().clamp(1, 12);
    final day = adjusted - ((709 * month) / 24).floor();
    final year = 30 * n + j - 30;
    return '$day ${months[month - 1]} $year AH';
  }
}
