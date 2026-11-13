import 'package:flutter/foundation.dart';

import '../../domain/models/user_wallet_models.dart';

/// Conversational assistant repository for Duya AI with structured route links.
class AiRepository extends ChangeNotifier {
  final List<AiMessage> _messages = [
    AiMessage(
      id: 'ai_welcome',
      isUser: false,
      text:
          'Assalamu Alaikum! I am Duya AI, your spiritual and pilgrimage companion. Ask me to build a Makkah & Madinah trip plan, guide your Tawaf & Sa‘i duas, or suggest heritage dining near Al-Haram.',
      timestamp: DateTime.now(),
      actionLinks: const [
        AiActionLink(label: 'Open Motawef Guide', route: '/motawef'),
        AiActionLink(label: 'AI Trip Builder', route: '/journey/trip-builder'),
      ],
    ),
  ];

  List<AiMessage> get messages => List.unmodifiable(_messages);

  static const List<String> quickPrompts = [
    'Build a 5-day Makkah & Madinah plan',
    'What duas should I recite in Tawaf?',
    'Show Al-Rawdah permit steps',
    'Best heritage restaurants near Haram',
  ];

  Future<void> sendMessage(String prompt) async {
    final trimmed = prompt.trim();
    if (trimmed.isEmpty) return;

    _messages.add(
      AiMessage(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        isUser: true,
        text: trimmed,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    final reply = _generateContextualReply(trimmed.toLowerCase());
    _messages.add(reply);
    notifyListeners();
  }

  AiMessage _generateContextualReply(String q) {
    if (q.contains('plan') || q.contains('trip') || q.contains('itinerary')) {
      return AiMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'Here is a balanced 5-day pilgrimage rhythm:\n• Days 1–3 (Makkah): Perform Umrah with the Motawef tracker, visit the Clock Tower Museum at Asr, and explore Hira Cultural District.\n• Days 4–5 (Madinah): Travel via Haramain High-Speed Rail, reserve your Al-Rawdah prayer slot, and walk Quba Boulevard to Masjid Quba.',
        timestamp: DateTime.now(),
        actionLinks: const [
          AiActionLink(label: 'Launch Trip Builder', route: '/journey/trip-builder'),
          AiActionLink(label: 'Clock Tower Tickets', route: '/journey/attraction/clock_tower_museum'),
        ],
      );
    }
    if (q.contains('tawaf') || q.contains('dua') || q.contains('sai')) {
      return AiMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'During Tawaf you may make any sincere dua from the heart. Between the Yemeni Corner and the Black Stone, the Prophet ﷺ recited:\n"Rabbana atina fid-dunya hasanatan wa fil-akhirati hasanatan wa qina ‘adhaban-nar."',
        timestamp: DateTime.now(),
        actionLinks: const [
          AiActionLink(label: 'Tawaf Lap Counter', route: '/motawef'),
          AiActionLink(label: 'Umrah & Tawaf Duas', route: '/content/duas/tawaf_sai'),
        ],
      );
    }
    if (q.contains('rawdah') || q.contains('permit')) {
      return AiMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'To visit Al-Rawdah Al-Sharifah, select an open Men or Women time window in Permits, arrive 15 minutes early at Gate 37 (Men) or Gate 25 (Women), and present your confirmed QR pass.',
        timestamp: DateTime.now(),
        actionLinks: const [
          AiActionLink(label: 'Reserve Rawdah Slot', route: '/permits'),
        ],
      );
    }
    if (q.contains('food') || q.contains('restaurant') || q.contains('eat')) {
      return AiMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'For authentic Hijazi heritage dining, try Abu Zaid Heritage in Makkah (famous for fresh foul and ma‘soub) or Abu Osaid in Madinah for traditional Madani mandi near Al-Masjid An-Nabawi.',
        timestamp: DateTime.now(),
        actionLinks: const [
          AiActionLink(label: 'Explore Heritage Dining', route: '/journey/places'),
        ],
      );
    }
    return AiMessage(
      id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
      isUser: false,
      text:
          'May Allah accept your worship and ease your journey. I can help you check prayer times, count Tawaf laps in Motawef, explore Duas & Qur’an recitations, or plan your Makkah & Madinah stay.',
      timestamp: DateTime.now(),
      actionLinks: const [
        AiActionLink(label: 'Duas & Athkar', route: '/content/duas'),
        AiActionLink(label: 'Holy Qur’an', route: '/content/quran'),
      ],
    );
  }
}
