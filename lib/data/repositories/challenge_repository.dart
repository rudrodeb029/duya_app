import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../../domain/models/challenge_models.dart';
import 'challenge_question_bank.dart';

/// Repository for the Daily Islamic Knowledge Challenge: 8 Doors, 160-question
/// bank (20 per door rotating daily), Ilm rewards balance, Referral code
/// redemption, Winners, and Support FAQs.
///
/// Ilm reward economy:
/// - Every day starts with [dailyIlmGift] Ilm.
/// - Opening a door costs [ilmPerDoor] Ilm; each door can be opened once a day.
/// - Each door holds 20 app-aligned questions and rotates cleanly every day.
/// - A correct answer earns a draw entry plus [ilmCorrectReward] Ilm.
/// - A wrong answer still earns [ilmLearningReward] Ilm for learning.
/// - Each redeemed invite code adds [ilmReferralReward] Ilm.
/// - Lifetime Ilm earned unlocks seeker levels (see [ilmLevel]).
class ChallengeRepository extends ChangeNotifier {
  ChallengeRepository({DateTime Function()? clock})
      : _clock = clock ?? DateTime.now {
    _activeDayNumber = _dayNumberFor(_clock());
  }

  static const int dailyIlmGift = 2;
  static const int ilmPerDoor = 1;
  static const int ilmCorrectReward = 2;
  static const int ilmLearningReward = 1;
  static const int ilmReferralReward = 3;

  /// Each door card serves 100 questions per day, rotating through 10 distinct
  /// 100-question sets across a 10-day cycle (1,000 questions per door total).
  static const int dailyQuestionsPerDoor = 100;
  static const int dailyCycleDays = 10;

  /// Minimum questions a user must answer in a door card to qualify/join.
  static const int minQuestionsToJoin = 10;

  static final DateTime _rotationEpoch = DateTime.utc(2026, 1, 1);

  /// Seeker levels unlocked by lifetime Ilm earned (threshold → title).
  static const List<({int threshold, String title})> ilmLevels = [
    (threshold: 0, title: 'Talib'),
    (threshold: 10, title: 'Seeker'),
    (threshold: 25, title: 'Scholar'),
    (threshold: 50, title: 'Alim'),
  ];

  final DateTime Function() _clock;
  late int _activeDayNumber;

  static int _dayNumberFor(DateTime dt) =>
      DateTime.utc(dt.year, dt.month, dt.day).difference(_rotationEpoch).inDays;

  int get _currentDayNumber => _dayNumberFor(_clock());

  int _ilmBalance = dailyIlmGift;
  int get ilmBalance {
    final daysElapsed = _currentDayNumber - _activeDayNumber;
    return daysElapsed > 0
        ? _ilmBalance + daysElapsed * dailyIlmGift
        : _ilmBalance;
  }

  int _ilmEarnedToday = 0;
  int get ilmEarnedToday =>
      _currentDayNumber == _activeDayNumber ? _ilmEarnedToday : 0;

  int _lifetimeIlm = 0;
  int get lifetimeIlm => _lifetimeIlm;

  int _drawEntriesCount = 0;
  int get drawEntriesCount => _drawEntriesCount;

  final Set<String> _redeemedCodes = {};
  final Map<int, Set<String>> _completedDoorsByDay = {};
  final Map<int, Map<String, int>> _answeredCountByDay = {};
  final Map<int, Map<String, int>> _correctCountByDay = {};

  Set<String> _doorsForDay(int day) => _completedDoorsByDay[day] ?? const {};

  /// True once the door has been unlocked/started today.
  bool isDoorCompleted(String doorId) =>
      _doorsForDay(_currentDayNumber).contains(doorId);

  int get completedDoorsCount => _doorsForDay(_currentDayNumber).length;

  /// Number of questions answered today in [doorId] (0 up to [dailyQuestionsPerDoor]).
  int answeredCountToday(String doorId) =>
      _answeredCountByDay[_currentDayNumber]?[doorId] ?? 0;

  /// Number of questions answered correctly today in [doorId].
  int correctCountToday(String doorId) =>
      _correctCountByDay[_currentDayNumber]?[doorId] ?? 0;

  /// How many more questions the user must answer in [doorId] today to reach
  /// the minimum [minQuestionsToJoin] (10) requirement.
  int remainingToJoin(String doorId) =>
      (minQuestionsToJoin - answeredCountToday(doorId))
          .clamp(0, minQuestionsToJoin);

  /// True once the user has answered at least [minQuestionsToJoin] (10)
  /// questions in [doorId] today.
  bool isDoorJoined(String doorId) =>
      answeredCountToday(doorId) >= minQuestionsToJoin;

  /// True once all of today's questions (100) for [doorId] have been answered.
  bool isDoorExhaustedToday(String doorId) {
    final dailyTotal = dailyQuestionsForDoor(doorId).length;
    return dailyTotal > 0 && answeredCountToday(doorId) >= dailyTotal;
  }

  /// A door can be opened/continued if not all 100 daily questions are finished
  /// and either it was already unlocked today or the user has [ilmPerDoor] Ilm.
  bool canOpenDoor(String doorId) =>
      !isDoorExhaustedToday(doorId) &&
      (isDoorCompleted(doorId) || ilmBalance >= ilmPerDoor);

  void _syncDayRollover() {
    final today = _currentDayNumber;
    if (today != _activeDayNumber) {
      final daysElapsed = today - _activeDayNumber;
      if (daysElapsed > 0) {
        _ilmBalance += daysElapsed * dailyIlmGift;
      }
      _ilmEarnedToday = 0;
      _activeDayNumber = today;
    }
  }

  String get ilmLevel {
    var title = ilmLevels.first.title;
    for (final level in ilmLevels) {
      if (_lifetimeIlm >= level.threshold) title = level.title;
    }
    return title;
  }

  /// Ilm still required to reach the next level, or null at max level.
  int? get ilmToNextLevel {
    for (final level in ilmLevels) {
      if (_lifetimeIlm < level.threshold) return level.threshold - _lifetimeIlm;
    }
    return null;
  }

  void _earnIlm(int amount) {
    _ilmBalance += amount;
    _ilmEarnedToday += amount;
    _lifetimeIlm += amount;
  }

  List<ChallengeDoor> get doors => const [
        ChallengeDoor(
          id: 'prophet',
          theme: DoorTheme.prophet,
          titleEn: "The Prophet's ﷺ",
          titleAr: 'باب السيرة النبوية',
          calligraphyAr: 'باب السيرة',
          subtitleEn: 'Seerah, character & prophetic wisdom',
          colorHex: 0xFF0A5C36,
          imageAsset: 'assets/images/door_prophet.png',
        ),
        ChallengeDoor(
          id: 'quran',
          theme: DoorTheme.quran,
          titleEn: 'The Qur’an',
          titleAr: 'باب القرآن الكريم',
          calligraphyAr: 'باب القرآن',
          subtitleEn: 'Surahs, verses & stories of guidance',
          colorHex: 0xFF237A65,
          imageAsset: 'assets/images/door_quran.png',
        ),
        ChallengeDoor(
          id: 'makkah',
          theme: DoorTheme.makkah,
          titleEn: 'Makkah & Al-Haram',
          titleAr: 'باب مكة والحرم',
          calligraphyAr: 'باب مكة',
          subtitleEn: 'Kaaba landmarks, Tawaf & sacred rites',
          colorHex: 0xFF9F7E54,
          imageAsset: 'assets/images/door_makkah.png',
        ),
        ChallengeDoor(
          id: 'madinah',
          theme: DoorTheme.madinah,
          titleEn: 'Madinah & Nabawi',
          titleAr: 'باب المدينة المنورة',
          calligraphyAr: 'باب المدينة',
          subtitleEn: 'Al-Rawdah, Quba & prophetic heritage',
          colorHex: 0xFF6B4E16,
          imageAsset: 'assets/images/door_madinah.png',
        ),
        ChallengeDoor(
          id: 'umrah',
          theme: DoorTheme.umrah,
          titleEn: 'Umrah Rituals',
          titleAr: 'باب مناسك العمرة',
          calligraphyAr: 'باب العمرة',
          subtitleEn: 'Miqat, Ihram, Sa‘i & step-by-step rites',
          colorHex: 0xFF14634C,
          imageAsset: 'assets/images/door_umrah.png',
        ),
        ChallengeDoor(
          id: 'hajj',
          theme: DoorTheme.hajj,
          titleEn: 'Hajj Pilgrimage',
          titleAr: 'باب مناسك الحج',
          calligraphyAr: 'باب الحج',
          subtitleEn: 'Arafah, Mina tents & Muzdalifah nights',
          colorHex: 0xFFC99A3B,
          imageAsset: 'assets/images/door_hajj.png',
        ),
        ChallengeDoor(
          id: 'prayer',
          theme: DoorTheme.prayer,
          titleEn: 'Prayer & Qibla',
          titleAr: 'باب الصلاة والقبلة',
          calligraphyAr: 'باب الصلاة',
          subtitleEn: 'Salah times, Qibla & Haram rewards',
          colorHex: 0xFF155E49,
          imageAsset: 'assets/images/door_prayer.png',
        ),
        ChallengeDoor(
          id: 'duas',
          theme: DoorTheme.duas,
          titleEn: 'Duas & Zamzam',
          titleAr: 'باب الأدعية وزمزم',
          calligraphyAr: 'باب الدعاء',
          subtitleEn: 'Prophetic supplications & Zamzam sunnah',
          colorHex: 0xFF1F7D61,
          imageAsset: 'assets/images/door_duas.png',
        ),
      ];

  List<QuizQuestion> _questions = challengeQuestionBank;
  late Map<String, List<QuizQuestion>> _questionsByDoor =
      _groupByDoor(challengeQuestionBank);
  bool _disposed = false;

  static Map<String, List<QuizQuestion>> _groupByDoor(
    List<QuizQuestion> items,
  ) {
    final grouped = <String, List<QuizQuestion>>{};
    for (final q in items) {
      (grouped[q.doorId] ??= <QuizQuestion>[]).add(q);
    }
    return {
      for (final entry in grouped.entries)
        entry.key: List<QuizQuestion>.unmodifiable(entry.value),
    };
  }

  List<QuizQuestion> get questions => _questions;

  List<QuizQuestion> questionsForDoor(String doorId) =>
      _questionsByDoor[doorId] ?? const [];

  /// Loads expanded per-door question banks from `assets/questions/<door.id>.json`.
  ///
  /// Falls back gracefully per door to [challengeQuestionBank] if an asset
  /// file is missing, invalid, or empty so partial states and tests never fail.
  Future<void> loadExpandedQuestions({AssetBundle? bundle}) async {
    final assetBundle = bundle ?? rootBundle;
    final fallbackByDoor = _groupByDoor(challengeQuestionBank);
    final mergedQuestions = <QuizQuestion>[];

    for (final door in doors) {
      final fallback = fallbackByDoor[door.id] ?? const <QuizQuestion>[];
      try {
        final rawJson =
            await assetBundle.loadString('assets/questions/${door.id}.json');
        final decoded = jsonDecode(rawJson);
        if (decoded is! List) {
          mergedQuestions.addAll(fallback);
          continue;
        }
        final loaded = <QuizQuestion>[];
        for (final entry in decoded) {
          if (entry is Map<String, dynamic>) {
            loaded.add(QuizQuestion.fromJson(entry));
          } else if (entry is Map) {
            loaded.add(QuizQuestion.fromJson(Map<String, dynamic>.from(entry)));
          }
        }
        mergedQuestions.addAll(loaded.isNotEmpty ? loaded : fallback);
      } catch (_) {
        mergedQuestions.addAll(fallback);
      }
    }

    if (_disposed) return;
    _questions = List<QuizQuestion>.unmodifiable(mergedQuestions);
    _questionsByDoor = _groupByDoor(_questions);
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  ChallengeDoor getDoorById(String doorId) {
    return doors.firstWhere(
      (d) => d.id == doorId,
      orElse: () => doors.first,
    );
  }

  /// Zero-based batch index (0..9) for today's 100-question set in [doorId].
  int dailyBatchIndexForDoor(String doorId, {DateTime? date}) {
    final doorQuestions = questionsForDoor(doorId);
    if (doorQuestions.isEmpty) return 0;
    final day = _dayNumberFor(date ?? _clock());
    if (doorQuestions.length >= dailyQuestionsPerDoor) {
      final numBatches = doorQuestions.length ~/ dailyQuestionsPerDoor;
      return ((day % numBatches) + numBatches) % numBatches;
    }
    return ((day % doorQuestions.length) + doorQuestions.length) %
        doorQuestions.length;
  }

  /// 1-based day number (1..10) within the 10-day 100-question cycle.
  int dailyCycleDayNumberForDoor(String doorId, {DateTime? date}) =>
      dailyBatchIndexForDoor(doorId, date: date) + 1;

  /// Returns today's 100-question slice for [doorId]. Across 10 consecutive
  /// days, this serves 10 completely distinct sets of 100 questions (1,000 total).
  List<QuizQuestion> dailyQuestionsForDoor(String doorId, {DateTime? date}) {
    final doorQuestions = questionsForDoor(doorId);
    if (doorQuestions.isEmpty) return const [];
    if (doorQuestions.length >= dailyQuestionsPerDoor) {
      final batch = dailyBatchIndexForDoor(doorId, date: date);
      final start = batch * dailyQuestionsPerDoor;
      final end = (start + dailyQuestionsPerDoor).clamp(0, doorQuestions.length);
      return doorQuestions.sublist(start, end);
    }
    final start = dailyBatchIndexForDoor(doorId, date: date);
    return [
      ...doorQuestions.sublist(start),
      ...doorQuestions.sublist(0, start),
    ];
  }

  /// Zero-based index within today's active question set for [doorId].
  int dailyQuestionIndexForDoor(String doorId, {DateTime? date}) {
    final dailyList = dailyQuestionsForDoor(doorId, date: date);
    if (dailyList.isEmpty) return 0;
    if (date != null) {
      return dailyBatchIndexForDoor(doorId, date: date);
    }
    return answeredCountToday(doorId).clamp(0, dailyList.length - 1);
  }

  /// Returns the current active question for [doorId]. When answering questions
  /// today ([date] == null), advances sequentially from question 1 through 100.
  QuizQuestion getQuestionForDoor(String doorId, {DateTime? date}) {
    final dailyList = dailyQuestionsForDoor(doorId, date: date);
    if (dailyList.isEmpty) return questions.first;
    final idx = date == null
        ? answeredCountToday(doorId).clamp(0, dailyList.length - 1)
        : 0;
    return dailyList[idx];
  }

  /// Submits a quiz answer for [question]. Unlocking a door on its first
  /// question of the day costs [ilmPerDoor] Ilm; subsequent questions (up to
  /// 100 per day) in that door are unlocked. Answering at least
  /// [minQuestionsToJoin] (10) questions qualifies the user in that door.
  bool submitAnswer({required QuizQuestion question, required int selectedIndex}) {
    _syncDayRollover();
    final doorId = question.doorId;
    if (!canOpenDoor(doorId)) return false;

    final alreadyUnlocked = isDoorCompleted(doorId);
    if (!alreadyUnlocked) {
      _ilmBalance -= ilmPerDoor;
      (_completedDoorsByDay[_activeDayNumber] ??= <String>{}).add(doorId);
    }

    final dayAnswered = (_answeredCountByDay[_activeDayNumber] ??= <String, int>{});
    dayAnswered[doorId] = (dayAnswered[doorId] ?? 0) + 1;

    final isCorrect = selectedIndex == question.correctIndex;
    if (isCorrect) {
      final dayCorrect = (_correctCountByDay[_activeDayNumber] ??= <String, int>{});
      dayCorrect[doorId] = (dayCorrect[doorId] ?? 0) + 1;
      _drawEntriesCount++;
      _earnIlm(ilmCorrectReward);
    } else {
      _earnIlm(ilmLearningReward);
    }
    notifyListeners();
    return isCorrect;
  }

  /// Validates a referral/promo code (`DUYA2026`, `BARAKAH`, `HARAMAIN`).
  ({bool success, String message}) redeemCode(String rawCode) {
    _syncDayRollover();
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) {
      return (success: false, message: 'Please enter a valid invite code.');
    }
    if (_redeemedCodes.contains(code)) {
      return (success: false, message: 'This code has already been redeemed.');
    }
    const validCodes = {'DUYA2026', 'BARAKAH', 'HARAMAIN', 'UMRAH100'};
    if (!validCodes.contains(code) && code.length < 6) {
      return (
        success: false,
        message: 'Code not recognized. Try DUYA2026 or BARAKAH.',
      );
    }
    _redeemedCodes.add(code);
    _earnIlm(ilmReferralReward);
    notifyListeners();
    return (
      success: true,
      message: '+$ilmReferralReward Ilm added to your Challenge balance!',
    );
  }

  List<ChallengeWinner> get winners => const [
        ChallengeWinner(
          id: 'win_1',
          displayName: 'SAMIRA BINTA ZAKARIA',
          prizeTitle: 'Umrah trip for two',
          country: 'Bangladesh',
          isToday: true,
          isSpotlight: true,
          dateLabel: 'Today',
        ),
        ChallengeWinner(
          id: 'win_2',
          displayName: 'YUSUF I***** K***',
          prizeTitle: 'Umrah trip for two',
          country: 'Indonesia',
          isToday: true,
          isSpotlight: false,
          dateLabel: 'Today',
        ),
        ChallengeWinner(
          id: 'win_3',
          displayName: 'NAEEM H*** M***',
          prizeTitle: '20 cartons of Zamzam water',
          country: 'Pakistan',
          isToday: false,
          isSpotlight: false,
          dateLabel: 'Yesterday',
        ),
        ChallengeWinner(
          id: 'win_4',
          displayName: 'AHMED E****** F***',
          prizeTitle: '20 cartons of Zamzam water',
          country: 'Egypt',
          isToday: false,
          isSpotlight: false,
          dateLabel: 'Yesterday',
        ),
        ChallengeWinner(
          id: 'win_5',
          displayName: 'HEBA G**** S*****',
          prizeTitle: '20 cartons of Zamzam water',
          country: 'Jordan',
          isToday: false,
          isSpotlight: false,
          dateLabel: '2 days ago',
        ),
      ];

  List<ChallengeFaq> get faqs => const [
        ChallengeFaq(
          question: 'What is the Duya Knowledge Challenge?',
          answer:
              'A daily spiritual quiz across eight doors (Prophetic Seerah, Qur’an, Makkah, Madinah, Umrah, Hajj, Prayer & Qibla, and Duas & Zamzam), featuring 20 curated questions per door that rotate every day.',
        ),
        ChallengeFaq(
          question: 'What is Ilm and how do I earn it?',
          answer:
              'Ilm (knowledge) is your Challenge reward. You receive 2 Ilm each day, +2 Ilm for every correct answer, +1 Ilm for every attempt (you still learn!), and +3 Ilm when friends join with your invite code (try DUYA2026 or BARAKAH).',
        ),
        ChallengeFaq(
          question: 'How is Ilm used?',
          answer:
              'Opening a door costs 1 Ilm, and each door can be opened once per day. Every correct answer secures an entry into that day’s draw, and lifetime Ilm raises your level from Talib to Seeker, Scholar and Alim.',
        ),
        ChallengeFaq(
          question: 'When is the draw held and how are winners contacted?',
          answer:
              'Draws take place daily after Isha Makkah time. Winners are announced in the Winners tab and contacted via verified account email.',
        ),
        ChallengeFaq(
          question: 'Are there any fees to take part, or is it free?',
          answer:
              'Participation is 100% free — no purchase or payment is ever required to enter.',
        ),
        ChallengeFaq(
          question: 'Is my personal data safe?',
          answer:
              'Yes. Only your initials/masked display name and country appear on public winner lists, and your profile details stay encrypted.',
        ),
      ];
}
