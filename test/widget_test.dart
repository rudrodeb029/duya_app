import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/data/repositories/auth_profile_repository.dart';
import 'package:my_app/data/repositories/challenge_repository.dart';
import 'package:my_app/data/repositories/prayer_ritual_repository.dart';
import 'package:my_app/data/services/prayer_calculation_service.dart';
import 'package:my_app/data/services/preferences_service.dart';
import 'package:my_app/domain/models/challenge_models.dart';
import 'package:my_app/domain/models/prayer_models.dart';

class _MemoryAssetBundle extends AssetBundle {
  _MemoryAssetBundle(this.assets);

  final Map<String, String> assets;

  @override
  Future<ByteData> load(String key) async {
    final value = assets[key];
    if (value == null) {
      throw FlutterError('Unable to load asset: "$key".');
    }
    final bytes = Uint8List.fromList(utf8.encode(value));
    return ByteData.sublistView(bytes);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final value = assets[key];
    if (value == null) {
      throw FlutterError('Unable to load asset: "$key".');
    }
    return value;
  }
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Domain & Repository Unit Tests', () {
    test('PrayerCalculationService computes 6 entries and valid Qibla bearing', () {
      final service = PrayerCalculationService();
      final dhaka = PrayerRitualRepository.availableLocations
          .firstWhere((l) => l.id == 'dhaka');

      final schedule = service.computeSchedule(
        location: dhaka,
        now: DateTime(2026, 11, 13, 10, 0),
        method: PrayerCalcMethod.ummAlQura,
        enabledAlerts: {PrayerName.fajr, PrayerName.isha},
      );

      expect(schedule.entries.length, 6);
      expect(schedule.qiblaBearingDegrees, inInclusiveRange(270, 290));
      expect(schedule.distanceToKaabaKm, greaterThan(4500));
    });

    test('ChallengeRepository has 8 doors x 20 daily-rotating questions & Ilm flow',
        () {
      var now = DateTime(2026, 11, 14, 10);
      final repo = ChallengeRepository(clock: () => now);
      final initialIlm = repo.ilmBalance;
      final initialLifetimeIlm = repo.lifetimeIlm;

      expect(repo.doors.length, 8);
      for (final door in repo.doors) {
        final doorQuestions = repo.questionsForDoor(door.id);
        expect(doorQuestions.length, 20);
        expect(doorQuestions.map((q) => q.id).toSet().length, 20);
        expect(repo.getQuestionForDoor(door.id).doorId, door.id);

        // Verify 20 consecutive days produce all 20 unique questions for each door.
        final seenIds = <String>{};
        for (var d = 0; d < 20; d++) {
          seenIds.add(
            repo.getQuestionForDoor(
              door.id,
              date: now.add(Duration(days: d)),
            ).id,
          );
        }
        expect(seenIds.length, 20);
      }

      final redeemed = repo.redeemCode('DUYA2026');
      expect(redeemed.success, isTrue);
      expect(repo.ilmBalance, initialIlm + ChallengeRepository.ilmReferralReward);

      final duplicate = repo.redeemCode('DUYA2026');
      expect(duplicate.success, isFalse);

      final balanceBeforeQuiz = repo.ilmBalance;
      final day1Question = repo.getQuestionForDoor('quran');
      final correct = repo.submitAnswer(
        question: day1Question,
        selectedIndex: day1Question.correctIndex,
      );
      expect(correct, isTrue);
      expect(repo.drawEntriesCount, 1);
      expect(repo.completedDoorsCount, 1);
      expect(repo.isDoorCompleted('quran'), isTrue);
      expect(
        repo.ilmBalance,
        balanceBeforeQuiz -
            ChallengeRepository.ilmPerDoor +
            ChallengeRepository.ilmCorrectReward,
      );
      expect(
        repo.lifetimeIlm,
        initialLifetimeIlm +
            ChallengeRepository.ilmReferralReward +
            ChallengeRepository.ilmCorrectReward,
      );

      // Advancing to the next day serves a new question and unlocks the door again.
      now = now.add(const Duration(days: 1));
      final day2Question = repo.getQuestionForDoor('quran');
      expect(day2Question.id, isNot(day1Question.id));
      expect(repo.isDoorCompleted('quran'), isFalse);
    });

    test('QuizQuestion.fromJson and toJson round-trip exact schema', () {
      const json = <String, dynamic>{
        'id': 'q_prophet_0001',
        'doorId': 'prophet',
        'questionEn': 'Where did the first revelation descend upon the Prophet ﷺ?',
        'optionsEn': ['Cave Hira', 'Cave Thawr', 'Masjid Quba', 'Mount Uhud'],
        'correctIndex': 0,
        'explanationEn': 'Angel Jibril (AS) first appeared in Cave Hira on Jabal al-Noor.',
        'reference': 'Sahih al-Bukhari 3',
      };

      final parsed = QuizQuestion.fromJson(json);
      expect(parsed.id, 'q_prophet_0001');
      expect(parsed.doorId, 'prophet');
      expect(parsed.questionEn, json['questionEn']);
      expect(parsed.optionsEn, equals(json['optionsEn']));
      expect(parsed.correctIndex, 0);
      expect(parsed.explanationEn, json['explanationEn']);
      expect(parsed.reference, 'Sahih al-Bukhari 3');
      expect(parsed.toJson(), equals(json));
    });

    test(
        'ChallengeRepository.loadExpandedQuestions loads asset JSON and falls back gracefully per door',
        () async {
      final now = DateTime(2026, 11, 14, 10);
      final repo = ChallengeRepository(clock: () => now);

      var notifications = 0;
      repo.addListener(() => notifications++);

      List<Map<String, dynamic>> buildDoorItems(String doorId, int count) {
        return List.generate(
          count,
          (i) => {
            'id': 'q_${doorId}_exp_${i + 1}',
            'doorId': doorId,
            'questionEn': 'Expanded $doorId question #${i + 1}?',
            'optionsEn': ['Option A', 'Option B', 'Option C', 'Option D'],
            'correctIndex': i % 4,
            'explanationEn': 'Explanation for $doorId #${i + 1}.',
            'reference': 'Authentic Reference ${i + 1}',
          },
        );
      }

      final mockBundle = _MemoryAssetBundle({
        'assets/questions/prophet.json':
            jsonEncode(buildDoorItems('prophet', 25)),
        'assets/questions/quran.json': jsonEncode(buildDoorItems('quran', 30)),
        'assets/questions/makkah.json': '{invalid json',
        'assets/questions/madinah.json': jsonEncode({'not': 'a list'}),
      });

      await repo.loadExpandedQuestions(bundle: mockBundle);

      expect(notifications, 1);
      expect(repo.questionsForDoor('prophet').length, 25);
      expect(repo.questionsForDoor('quran').length, 30);

      // Corrupted/invalid and missing doors fall back cleanly to 20 questions.
      expect(repo.questionsForDoor('makkah').length, 20);
      expect(repo.questionsForDoor('madinah').length, 20);
      expect(repo.questionsForDoor('umrah').length, 20);
      expect(repo.questionsForDoor('hajj').length, 20);
      expect(repo.questionsForDoor('prayer').length, 20);
      expect(repo.questionsForDoor('duas').length, 20);

      // Total = 25 + 30 + (6 * 20) = 175.
      expect(repo.questions.length, 175);

      // Rotation seamlessly spans all 25 loaded prophet questions.
      final seenProphetIds = <String>{};
      for (var d = 0; d < 25; d++) {
        seenProphetIds.add(
          repo.getQuestionForDoor('prophet', date: now.add(Duration(days: d))).id,
        );
      }
      expect(seenProphetIds.length, 25);

      // Missing-asset bundle fallback keeps all 160 fallback questions intact.
      await repo.loadExpandedQuestions(bundle: _MemoryAssetBundle(const {}));
      expect(notifications, 2);
      expect(repo.questions.length, 160);
      for (final door in repo.doors) {
        expect(repo.questionsForDoor(door.id).length, 20);
      }

      // Real rootBundle assets load all 8 doors x 1,000 questions = 8,000 total.
      await repo.loadExpandedQuestions();
      expect(repo.questions.length, 8000);
      for (final door in repo.doors) {
        final doorQs = repo.questionsForDoor(door.id);
        expect(doorQs.length, 1000, reason: 'Door ${door.id} should have 1000 questions');
        expect(doorQs.first.id, 'q_${door.id}_0001');
        expect(doorQs.last.id, 'q_${door.id}_1000');

        // 10 consecutive days each serve 100 distinct questions (1,000 total).
        final seenAcross10Days = <String>{};
        for (var dayOffset = 0; dayOffset < 10; dayOffset++) {
          final dailySlice = repo.dailyQuestionsForDoor(
            door.id,
            date: now.add(Duration(days: dayOffset)),
          );
          expect(dailySlice.length, 100);
          seenAcross10Days.addAll(dailySlice.map((q) => q.id));
        }
        expect(seenAcross10Days.length, 1000);
      }

      // Sequential 1..100 progression and minimum 10 questions to join:
      final todaySlice = repo.dailyQuestionsForDoor('prophet');
      expect(todaySlice.length, 100);
      expect(repo.answeredCountToday('prophet'), 0);
      expect(repo.isDoorJoined('prophet'), isFalse);
      expect(repo.remainingToJoin('prophet'), 10);

      for (var i = 0; i < 100; i++) {
        final activeQ = repo.getQuestionForDoor('prophet');
        expect(activeQ.id, todaySlice[i].id);
        repo.submitAnswer(question: activeQ, selectedIndex: activeQ.correctIndex);
        expect(repo.answeredCountToday('prophet'), i + 1);
        if (i + 1 < 10) {
          expect(repo.isDoorJoined('prophet'), isFalse);
          expect(repo.remainingToJoin('prophet'), 10 - (i + 1));
        } else {
          expect(repo.isDoorJoined('prophet'), isTrue);
          expect(repo.remainingToJoin('prophet'), 0);
        }
      }
      expect(repo.isDoorExhaustedToday('prophet'), isTrue);
    });
  });

  group('Duya App Widget & Navigation Smoke Tests', () {
    testWidgets('Onboarding advances to Welcome gate and guest enters Home',
        (tester) async {
      final prefs = PreferencesService();
      final auth = AuthProfileRepository(prefs: prefs);

      await tester.pumpWidget(
        DuyaApp(authRepository: auth, initialLocation: '/onboarding'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Umrah in Minutes'), findsOneWidget);

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(
        find.text('Are you ready to begin your spiritual journey?'),
        findsOneWidget,
      );

      await tester.tap(find.text('Explore as Guest'));
      await tester.pumpAndSettle();

      expect(find.text('Rawdah'), findsOneWidget);
      expect(find.text('Start the Challenge'), findsOneWidget);
    });

    testWidgets('Shell tabs switch cleanly between Home, Journey, Content, Market',
        (tester) async {
      final prefs = PreferencesService();
      final auth = AuthProfileRepository(prefs: prefs);
      await auth.continueAsGuest();

      await tester.pumpWidget(
        DuyaApp(authRepository: auth, initialLocation: '/home'),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Journey'));
      await tester.pumpAndSettle();
      expect(find.text('Your Journey'), findsOneWidget);

      await tester.tap(find.byTooltip('Content'));
      await tester.pumpAndSettle();
      expect(find.text('Content Hub'), findsOneWidget);

      await tester.tap(find.byTooltip('Market'));
      await tester.pumpAndSettle();
      expect(find.text('Duya Market'), findsOneWidget);
    });

    testWidgets('Daily Challenge intro enters Doors hub and Duya AI responds',
        (tester) async {
      final prefs = PreferencesService();
      final auth = AuthProfileRepository(prefs: prefs);
      await auth.continueAsGuest();

      await tester.pumpWidget(
        DuyaApp(authRepository: auth, initialLocation: '/challenge/intro'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Umrah Knowledge Challenge'), findsOneWidget);
      await tester.ensureVisible(find.text('Play Now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Play Now'));
      await tester.pumpAndSettle();

      expect(find.text('Choose a door'), findsOneWidget);

      await tester.pumpWidget(
        DuyaApp(
          key: const ValueKey('ai-test'),
          authRepository: auth,
          initialLocation: '/ai',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Duya AI Companion'), findsOneWidget);
    });
  });
}
