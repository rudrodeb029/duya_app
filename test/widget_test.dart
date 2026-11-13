import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/data/repositories/auth_profile_repository.dart';
import 'package:my_app/data/repositories/challenge_repository.dart';
import 'package:my_app/data/repositories/prayer_ritual_repository.dart';
import 'package:my_app/data/services/prayer_calculation_service.dart';
import 'package:my_app/data/services/preferences_service.dart';
import 'package:my_app/domain/models/prayer_models.dart';

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

    test('ChallengeRepository redeems valid invite code and scores quiz', () {
      final repo = ChallengeRepository();
      final initialKeys = repo.keysCount;

      final redeemed = repo.redeemCode('DUYA2026');
      expect(redeemed.success, isTrue);
      expect(repo.keysCount, initialKeys + 1);

      final duplicate = repo.redeemCode('DUYA2026');
      expect(duplicate.success, isFalse);

      final quranQuestion = repo.getQuestionForDoor('quran');
      final correct = repo.submitAnswer(
        question: quranQuestion,
        selectedIndex: quranQuestion.correctIndex,
      );
      expect(correct, isTrue);
      expect(repo.drawEntriesCount, 1);
      expect(repo.keysCount, initialKeys);
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
