import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';

/// Qur'an Reader with Uthmani Arabic script, translation, tafsir toggle,
/// font-size slider, ayah bookmarking, and Qari audio bar.
class QuranReaderView extends StatefulWidget {
  const QuranReaderView({
    super.key,
    required this.surahNumber,
    this.reciterId = 'sudais',
  });

  final int surahNumber;
  final String reciterId;

  @override
  State<QuranReaderView> createState() => _QuranReaderViewState();
}

class _QuranReaderViewState extends State<QuranReaderView> {
  double _arabicFontSize = 25;
  bool _showTafsir = false;
  bool _isPlaying = false;
  int _activeAyahIdx = 0;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final auth = context.watch<AuthProfileRepository>();
    final surah = repo.getSurahByNumber(widget.surahNumber);
    final reciter = repo.reciters.firstWhere(
      (r) => r.id == widget.reciterId,
      orElse: () => repo.reciters.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${surah.nameEnglish} (${surah.nameArabic})'),
        actions: [
          IconButton(
            tooltip: 'Toggle Tafsir notes',
            onPressed: () => setState(() => _showTafsir = !_showTafsir),
            icon: Icon(
              _showTafsir ? Icons.lightbulb : Icons.lightbulb_outline,
              color: _showTafsir ? DuyaColors.desertGold : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text('Arabic Size', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: _arabicFontSize,
                    min: 20,
                    max: 34,
                    onChanged: (v) => setState(() => _arabicFontSize = v),
                  ),
                ),
                Chip(
                  label: Text('${surah.revelationPlace} • ${surah.ayahCount} Ayahs'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: surah.ayahs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final ayah = surah.ayahs[index];
                final isBookmarked = auth.bookmarkedAyahKeys.contains(ayah.key);
                final isActiveAudio = _isPlaying && _activeAyahIdx == index;

                return DuyaCard(
                  color: isActiveAudio ? DuyaColors.desertGoldSoft : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: DuyaColors.desertGoldSoft,
                            child: Text(
                              '${ayah.ayahNumber}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: DuyaColors.emerald,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => setState(() {
                              _activeAyahIdx = index;
                              _isPlaying = true;
                            }),
                            icon: Icon(
                              isActiveAudio
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline,
                              color: DuyaColors.emerald,
                            ),
                          ),
                          IconButton(
                            onPressed: () => auth.toggleAyahBookmark(ayah.key),
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isBookmarked ? DuyaColors.desertGold : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ayah.arabicText,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: DuyaTypography.arabicScript(
                          fontSize: _arabicFontSize,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ayah.translationEn,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (_showTafsir) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Reflection: ${ayah.tafsirNote}',
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          // Persistent Qari Audio Bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
            decoration: const BoxDecoration(
              color: DuyaColors.celestialNight,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: DuyaColors.desertGold,
                    child: Icon(Icons.headphones, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          reciter.nameEn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _isPlaying
                              ? 'Reciting Ayah ${surah.ayahs[_activeAyahIdx].ayahNumber}...'
                              : 'Tap play to listen to ${surah.nameEnglish}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _isPlaying = !_isPlaying),
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: DuyaColors.desertGold,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
