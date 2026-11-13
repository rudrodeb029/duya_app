import 'package:flutter/foundation.dart';

import '../../domain/models/challenge_models.dart';

/// Repository for the Daily Islamic Knowledge Challenge: 4 Doors, Quiz bank,
/// Keys balance, Referral code redemption, Winners, and Support FAQs.
class ChallengeRepository extends ChangeNotifier {
  int _keysCount = 2;
  int get keysCount => _keysCount;

  int _drawEntriesCount = 0;
  int get drawEntriesCount => _drawEntriesCount;

  final Set<String> _redeemedCodes = {};

  List<ChallengeDoor> get doors => const [
        ChallengeDoor(
          id: 'prophet',
          theme: DoorTheme.prophet,
          titleEn: "The Prophet's ﷺ",
          titleAr: 'باب السيرة النبوية',
          subtitleEn: 'Seerah, character & prophetic wisdom',
          colorHex: 0xFF0A5C36,
        ),
        ChallengeDoor(
          id: 'quran',
          theme: DoorTheme.quran,
          titleEn: 'The Qur’an',
          titleAr: 'باب القرآن الكريم',
          subtitleEn: 'Surahs, verses & stories of guidance',
          colorHex: 0xFF237A65,
        ),
        ChallengeDoor(
          id: 'makkah',
          theme: DoorTheme.makkah,
          titleEn: 'Makkah & Al-Haram',
          titleAr: 'باب مكة والحرم',
          subtitleEn: 'Kaaba landmarks, history & rituals',
          colorHex: 0xFF9F7E54,
        ),
        ChallengeDoor(
          id: 'madinah',
          theme: DoorTheme.madinah,
          titleEn: 'Madinah & Nabawi',
          titleAr: 'باب المدينة المنورة',
          subtitleEn: 'Al-Rawdah, Quba & early Muslim heritage',
          colorHex: 0xFF6B4E16,
        ),
      ];

  List<QuizQuestion> get questions => const [
        QuizQuestion(
          id: 'q_quran_1',
          doorId: 'quran',
          questionEn: "In which surah are Luqman's counsels to his son found?",
          optionsEn: ['Luqman', 'Al-Isra', 'Al-Hujurat', "Al-An'am"],
          correctIndex: 0,
          explanationEn:
              "Surah Luqman (Chapter 31, verses 12–19) preserves Luqman the Wise's heartfelt advice to his son on gratitude, prayer, humility, and patience.",
          reference: 'Surah Luqman 31:12–19',
        ),
        QuizQuestion(
          id: 'q_prophet_1',
          doorId: 'prophet',
          questionEn:
              'Which title did the people of Makkah famously give Prophet Muhammad ﷺ even before prophethood?',
          optionsEn: [
            'Al-Sadiq Al-Amin',
            'Al-Faruq',
            'Dhun-Nurayn',
            'Sayfullah',
          ],
          correctIndex: 0,
          explanationEn:
              'He ﷺ was universally trusted as Al-Sadiq Al-Amin (The Truthful, The Trustworthy).',
          reference: 'Seerah Ibn Hisham',
        ),
        QuizQuestion(
          id: 'q_makkah_1',
          doorId: 'makkah',
          questionEn:
              'Between which two points does the pilgrim walk briskly during the 7 circuits of Sa‘i?',
          optionsEn: [
            'Safa and Marwah',
            'Arafah and Mina',
            'Muzdalifah and Quba',
            'Maqam Ibrahim and Zamzam',
          ],
          correctIndex: 0,
          explanationEn:
              'Sa‘i commemorates Hajar’s search for water between Mount Safa and Mount Marwah.',
          reference: 'Surah Al-Baqarah 2:158',
        ),
        QuizQuestion(
          id: 'q_madinah_1',
          doorId: 'madinah',
          questionEn:
              'Which mosque was the very first established by the Prophet ﷺ upon arriving near Madinah?',
          optionsEn: [
            'Masjid Quba',
            'Masjid Al-Qiblatayn',
            'Masjid Al-Ghamamah',
            'Masjid Al-Khayf',
          ],
          correctIndex: 0,
          explanationEn:
              'Masjid Quba was founded on the outskirts of Madinah; praying two rak‘ahs there equals the reward of an Umrah.',
          reference: 'Sunan al-Tirmidhi 324',
        ),
      ];

  ChallengeDoor getDoorById(String doorId) {
    return doors.firstWhere(
      (d) => d.id == doorId,
      orElse: () => doors.first,
    );
  }

  QuizQuestion getQuestionForDoor(String doorId) {
    return questions.firstWhere(
      (q) => q.doorId == doorId,
      orElse: () => questions.first,
    );
  }

  /// Submits a quiz answer, consuming 1 key. Returns true if answer is correct.
  bool submitAnswer({required QuizQuestion question, required int selectedIndex}) {
    if (_keysCount <= 0) return false;
    _keysCount--;
    final isCorrect = selectedIndex == question.correctIndex;
    if (isCorrect) {
      _drawEntriesCount++;
    }
    notifyListeners();
    return isCorrect;
  }

  /// Validates a referral/promo code (`DUYA2026`, `BARAKAH`, `HARAMAIN`).
  ({bool success, String message}) redeemCode(String rawCode) {
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
    _keysCount++;
    notifyListeners();
    return (success: true, message: '+1 Key added to your Challenge balance!');
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
              'A daily spiritual quiz across four doors (Prophetic Seerah, Qur’an, Makkah, and Madinah) designed to enrich Islamic knowledge with daily prize draws.',
        ),
        ChallengeFaq(
          question: 'How do I get keys?',
          answer:
              'You receive one free key at the start of each day, and you earn bonus keys when friends join using your referral code (try DUYA2026 or BARAKAH).',
        ),
        ChallengeFaq(
          question: 'How many keys can I use per day?',
          answer:
              'Each key unlocks one door question. Every correct answer secures an entry into that day’s draw.',
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
