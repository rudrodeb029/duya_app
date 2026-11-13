import 'package:flutter/foundation.dart';

import '../../domain/models/prayer_models.dart';
import '../../domain/models/ritual_models.dart';
import '../services/prayer_calculation_service.dart';

/// Repository for Prayer Times, Qibla Bearing, Motawef Ritual Tracker,
/// Rawdah/Umrah Permits, and Haram Accessibility & Zamzam Services.
class PrayerRitualRepository extends ChangeNotifier {
  PrayerRitualRepository({required this._calcService});

  final PrayerCalculationService _calcService;

  static const List<PrayerLocation> availableLocations = [
    PrayerLocation(
      id: 'makkah',
      cityName: 'Makkah',
      cityNameAr: 'مكة المكرمة',
      countryName: 'Saudi Arabia',
      latitude: 21.4225,
      longitude: 39.8262,
      utcOffsetHours: 3,
    ),
    PrayerLocation(
      id: 'madinah',
      cityName: 'Madinah',
      cityNameAr: 'المدينة المنورة',
      countryName: 'Saudi Arabia',
      latitude: 24.4672,
      longitude: 39.6112,
      utcOffsetHours: 3,
    ),
    PrayerLocation(
      id: 'riyadh',
      cityName: 'Riyadh',
      cityNameAr: 'الرياض',
      countryName: 'Saudi Arabia',
      latitude: 24.7136,
      longitude: 46.6753,
      utcOffsetHours: 3,
    ),
    PrayerLocation(
      id: 'dhaka',
      cityName: 'Dhaka',
      cityNameAr: 'دكا',
      countryName: 'Bangladesh',
      latitude: 23.8103,
      longitude: 90.4125,
      utcOffsetHours: 6,
    ),
    PrayerLocation(
      id: 'cairo',
      cityName: 'Cairo',
      cityNameAr: 'القاهرة',
      countryName: 'Egypt',
      latitude: 30.0444,
      longitude: 31.2357,
      utcOffsetHours: 2,
    ),
    PrayerLocation(
      id: 'london',
      cityName: 'London',
      cityNameAr: 'لندن',
      countryName: 'United Kingdom',
      latitude: 51.5072,
      longitude: -0.1276,
      utcOffsetHours: 0,
    ),
  ];

  PrayerLocation _selectedLocation = availableLocations.first;
  PrayerLocation get selectedLocation => _selectedLocation;

  PrayerCalcMethod _method = PrayerCalcMethod.ummAlQura;
  PrayerCalcMethod get method => _method;

  final Set<PrayerName> _enabledAlerts = {
    PrayerName.fajr,
    PrayerName.dhuhr,
    PrayerName.asr,
    PrayerName.maghrib,
    PrayerName.isha,
  };

  int _tawafLap = 0;
  int get tawafLap => _tawafLap;

  int _saiLap = 0;
  int get saiLap => _saiLap;

  int _activeMotawefStepIndex = 0;
  int get activeMotawefStepIndex => _activeMotawefStepIndex;

  final List<PermitBooking> _permitBookings = [];
  List<PermitBooking> get permitBookings => List.unmodifiable(_permitBookings);

  final List<HaramServiceRequest> _haramRequests = [];
  List<HaramServiceRequest> get haramRequests => List.unmodifiable(_haramRequests);

  DailyPrayerSchedule getSchedule([DateTime? referenceTime]) {
    return _calcService.computeSchedule(
      location: _selectedLocation,
      now: referenceTime ?? DateTime.now(),
      method: _method,
      enabledAlerts: _enabledAlerts,
    );
  }

  void selectLocation(PrayerLocation location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void selectMethod(PrayerCalcMethod method) {
    _method = method;
    notifyListeners();
  }

  void togglePrayerAlert(PrayerName name) {
    if (_enabledAlerts.contains(name)) {
      _enabledAlerts.remove(name);
    } else {
      _enabledAlerts.add(name);
    }
    notifyListeners();
  }

  void setActiveMotawefStep(int index) {
    _activeMotawefStepIndex = index.clamp(0, motawefSteps.length - 1);
    notifyListeners();
  }

  void incrementTawafLap() {
    if (_tawafLap < 7) {
      _tawafLap++;
      notifyListeners();
    }
  }

  void resetTawafLap() {
    _tawafLap = 0;
    notifyListeners();
  }

  void incrementSaiLap() {
    if (_saiLap < 7) {
      _saiLap++;
      notifyListeners();
    }
  }

  void resetSaiLap() {
    _saiLap = 0;
    notifyListeners();
  }

  PermitBooking bookPermit(PermitSlot slot, String holderName) {
    final booking = PermitBooking(
      id: 'prm_${DateTime.now().millisecondsSinceEpoch}',
      slot: slot,
      holderName: holderName,
      permitCode: 'DY-${(100000 + _permitBookings.length * 731).toString()}',
      status: 'Confirmed',
    );
    _permitBookings.insert(0, booking);
    notifyListeners();
    return booking;
  }

  HaramServiceRequest requestHaramService({
    required String serviceType,
    required String gateLocation,
    required String timeWindow,
  }) {
    final req = HaramServiceRequest(
      id: 'hrm_${DateTime.now().millisecondsSinceEpoch}',
      serviceType: serviceType,
      gateLocation: gateLocation,
      timeWindow: timeWindow,
      status: 'Scheduled',
    );
    _haramRequests.insert(0, req);
    notifyListeners();
    return req;
  }

  List<MotawefStep> get motawefSteps => const [
        MotawefStep(
          phase: MotawefPhase.ihram,
          stepNumber: 1,
          titleEn: 'Ihram & Niyyah at Miqat',
          titleAr: 'الإحرام والنية عند الميقات',
          summaryEn:
              'Perform ghusl, wear Ihram garments, and make the intention for Umrah before crossing the Miqat.',
          checklist: [
            'Perform ritual purification (Ghusl) and apply light fragrance before Ihram.',
            'Wear two clean unstitched white cloths (men) or modest clothing (women).',
            'Recite Labbaik Allahumma Umrah and begin the Talbiyah.',
          ],
          duaArabic:
              'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لَا شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لَا شَرِيكَ لَكَ',
          duaTransliteration:
              'Labbayk Allahumma labbayk, labbayka la sharika laka labbayk. Innal-hamda wan-ni‘mata laka wal-mulk, la sharika lak.',
          duaTranslation:
              'Here I am, O Allah, here I am. Here I am, You have no partner, here I am. Verily all praise, grace and sovereignty belong to You.',
          hasLapCounter: false,
          totalLaps: 0,
        ),
        MotawefStep(
          phase: MotawefPhase.tawaf,
          stepNumber: 2,
          titleEn: 'Tawaf Around the Kaaba (7 Circuits)',
          titleAr: 'الطواف حول الكعبة (٧ أشواط)',
          summaryEn:
              'Begin at the Black Stone line (green light), keeping the Kaaba on your left, and complete 7 counter-clockwise circuits.',
          checklist: [
            'Face the Black Stone, raise right hand and say Bismillah, Allahu Akbar.',
            'Men perform Idtiba (uncover right shoulder) and Raml in the first 3 rounds.',
            'Between the Yemeni Corner and Black Stone recite Rabbana atina fid-dunya hasanah.',
          ],
          duaArabic:
              'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
          duaTransliteration:
              'Rabbana atina fid-dunya hasanatan wa fil-akhirati hasanatan wa qina ‘adhaban-nar.',
          duaTranslation:
              'Our Lord, grant us good in this world and good in the Hereafter, and protect us from the punishment of the Fire.',
          hasLapCounter: true,
          totalLaps: 7,
        ),
        MotawefStep(
          phase: MotawefPhase.maqamIbrahim,
          stepNumber: 3,
          titleEn: 'Two Rak‘ahs Behind Maqam Ibrahim',
          titleAr: 'ركعتان خلف مقام إبراهيم',
          summaryEn:
              'Cover the right shoulder, proceed behind Maqam Ibrahim (or anywhere in the Mataf), and pray two light rak‘ahs.',
          checklist: [
            'Recite Wattakhidhu min maqami Ibrahima musalla.',
            'Pray 1st rak‘ah with Surah Al-Kafirun and 2nd with Surah Al-Ikhlas.',
          ],
          duaArabic: 'وَاتَّخِذُوا مِن مَّقَامِ إِبْرَاهِيمَ مُصَلًّى',
          duaTransliteration: 'Wattakhidhu min maqami Ibrahima musalla.',
          duaTranslation:
              'And take the Station of Ibrahim as a place of prayer.',
          hasLapCounter: false,
          totalLaps: 0,
        ),
        MotawefStep(
          phase: MotawefPhase.zamzam,
          stepNumber: 4,
          titleEn: 'Drink Zamzam & Make Dua',
          titleAr: 'شرب ماء زمزم والدعاء',
          summaryEn:
              'Drink blessed Zamzam water while facing the Qibla and supplicate sincerely for beneficial knowledge, provision, and healing.',
          checklist: [
            'Say Bismillah and drink in three breaths.',
            'Supplicate from the heart — Zamzam is for whatever purpose it is drunk.',
          ],
          duaArabic:
              'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا وَاسِعًا، وَشِفَاءً مِنْ كُلِّ دَاءٍ',
          duaTransliteration:
              'Allahumma inni as’aluka ‘ilman nafi‘an, wa rizqan wasi‘an, wa shifa’an min kulli da’.',
          duaTranslation:
              'O Allah, I ask You for beneficial knowledge, abundant provision, and healing from every illness.',
          hasLapCounter: false,
          totalLaps: 0,
        ),
        MotawefStep(
          phase: MotawefPhase.sai,
          stepNumber: 5,
          titleEn: "Sa'i Between Safa & Marwah (7 Laps)",
          titleAr: 'السعي بين الصفا والمروة (٧ أشواط)',
          summaryEn:
              'Begin at Mount Safa and walk to Marwah (Lap 1), returning from Marwah to Safa (Lap 2), ending at Marwah on Lap 7.',
          checklist: [
            'Recite Innas-Safa wal-Marwata min sha‘a’irillah when approaching Safa.',
            'Men jog briskly between the two green-lit pillars.',
            'Face the Kaaba at Safa and Marwah to make lengthy dua.',
          ],
          duaArabic:
              'إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللَّهِ ۖ فَمَنْ حَجَّ الْبَيْتَ أَوِ اعْتَمَرَ فَلَا جُنَاحَ عَلَيْهِ أَن يَطَّوَّفَ بِهِمَا',
          duaTransliteration:
              'Innas-Safa wal-Marwata min sha‘a’irillah, faman hajjal-bayta awi‘tamara fala junaha ‘alayhi an yattawwafa bihima.',
          duaTranslation:
              'Indeed, Safa and Marwah are among the symbols of Allah. So whoever makes Hajj or Umrah has no blame in walking between them.',
          hasLapCounter: true,
          totalLaps: 7,
        ),
        MotawefStep(
          phase: MotawefPhase.tahallul,
          stepNumber: 6,
          titleEn: 'Halq or Taqsir (Exit Ihram)',
          titleAr: 'الحلق أو التقصير والتحلل',
          summaryEn:
              'Men shave or trim hair evenly across the head; women trim a fingertip length from the ends of their hair. Your Umrah is complete!',
          checklist: [
            'Men: Shaving (Halq) holds greater reward, or trim evenly (Taqsir).',
            'Women: Trim approximately one fingertip length from the hair ends.',
            'All Ihram restrictions are now lifted — Alhamdulillah!',
          ],
          duaArabic: 'الْحَمْدُ لِلَّهِ الَّذِي بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ',
          duaTransliteration:
              'Alhamdu lillahil-ladhi bini‘matihi tatimmus-salihat.',
          duaTranslation:
              'All praise is due to Allah by whose grace good deeds are completed.',
          hasLapCounter: false,
          totalLaps: 0,
        ),
      ];

  List<PermitSlot> get permitSlots => const [
        PermitSlot(
          id: 'slot_rawdah_m_1',
          type: 'rawdah_men',
          titleEn: 'Al-Rawdah Al-Sharifah (Men)',
          titleAr: 'الروضة الشريفة (للرجال)',
          locationLabel: "Al-Masjid An-Nabawi • Gate 37",
          dateLabel: 'Tomorrow',
          timeWindow: '05:30 AM – 06:15 AM',
          availabilityLabel: '14 slots left',
          isAvailable: true,
        ),
        PermitSlot(
          id: 'slot_rawdah_w_1',
          type: 'rawdah_women',
          titleEn: 'Al-Rawdah Al-Sharifah (Women)',
          titleAr: 'الروضة الشريفة (للنساء)',
          locationLabel: "Al-Masjid An-Nabawi • Gate 25",
          dateLabel: 'Tomorrow',
          timeWindow: '08:00 AM – 09:00 AM',
          availabilityLabel: '9 slots left',
          isAvailable: true,
        ),
        PermitSlot(
          id: 'slot_umrah_1',
          type: 'umrah',
          titleEn: 'Umrah Entry Permit',
          titleAr: 'تصريح أداء العمرة',
          locationLabel: 'Al-Masjid Al-Haram • King Abdulaziz Gate',
          dateLabel: 'Today',
          timeWindow: '09:00 PM – 11:59 PM',
          availabilityLabel: 'High availability',
          isAvailable: true,
        ),
        PermitSlot(
          id: 'slot_umrah_2',
          type: 'umrah',
          titleEn: 'Umrah Entry Permit (Fajr Window)',
          titleAr: 'تصريح عمرة (فترة الفجر)',
          locationLabel: 'Al-Masjid Al-Haram • Bab Al-Umrah',
          dateLabel: 'Tomorrow',
          timeWindow: '04:00 AM – 06:30 AM',
          availabilityLabel: 'Available',
          isAvailable: true,
        ),
      ];
}
