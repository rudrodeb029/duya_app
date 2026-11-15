import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';

/// Holy Qur'an Index with Surah list, Qari reciter directory, and Saved Bookmarks.
class QuranIndexView extends StatefulWidget {
  const QuranIndexView({super.key, this.initialReciterId});

  final String? initialReciterId;

  @override
  State<QuranIndexView> createState() => _QuranIndexViewState();
}

class _QuranIndexViewState extends State<QuranIndexView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _selectedReciterId = 'sudais';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (widget.initialReciterId != null) {
      _selectedReciterId = widget.initialReciterId!;
      _tabController.index = 1;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final auth = context.watch<AuthProfileRepository>();

    final filteredSurahs = repo.surahs.where((s) {
      final q = _searchQuery.toLowerCase();
      return s.nameEnglish.toLowerCase().contains(q) ||
          s.meaningEnglish.toLowerCase().contains(q) ||
          s.number.toString() == q;
    }).toList();

    return DuyaSubpageScaffold(
      title: 'The Holy Qur’an',
      headerBottom: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: DuyaColors.emerald.withValues(alpha: 0.08),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: DuyaColors.emerald,
          indicatorColor: DuyaColors.emerald,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Surahs'),
            Tab(text: 'Reciters'),
            Tab(text: 'Bookmarks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Surahs Tab
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
            children: [
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: DuyaColors.emerald),
                  hintText: 'Search surah by name or number...',
                ),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
              const SizedBox(height: 16),
              ...filteredSurahs.map(
                (surah) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DuyaCard(
                    onTap: () => context.push(
                      '/content/quran/surah/${surah.number}?reciter=$_selectedReciterId',
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F3EE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${surah.number}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: DuyaColors.emerald,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surah.nameEnglish,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${surah.meaningEnglish} • ${surah.ayahCount} Ayahs • Juz ${surah.juzNumber}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          surah.nameArabic,
                          style: DuyaTypography.arabicScript(
                            fontSize: 19,
                            color: DuyaColors.emerald,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Reciters Tab
          ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: repo.reciters.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final r = repo.reciters[index];
              final selected = r.id == _selectedReciterId;
              return DuyaCard(
                color: selected ? DuyaColors.desertGoldSoft : null,
                onTap: () {
                  setState(() => _selectedReciterId = r.id);
                  _tabController.animateTo(0);
                },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Color(0xFFE7F3EE),
                          child: Icon(
                            Icons.volume_up,
                            color: DuyaColors.emerald,
                          ),
                        ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.nameEn,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                            ),
                          ),
                          Text(r.style),
                          Text(
                            '${r.surahCount} Audios Available',
                            style: const TextStyle(
                              color: DuyaColors.emerald,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selected)
                      const Icon(Icons.check_circle, color: DuyaColors.emerald),
                  ],
                ),
              );
            },
          ),
          // Bookmarks Tab
          ListView(
            padding: const EdgeInsets.all(20),
            children: auth.bookmarkedAyahKeys.isEmpty
                ? [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No bookmarked ayahs yet.'),
                      ),
                    ),
                  ]
                : auth.bookmarkedAyahKeys.map((key) {
                    final parts = key.split(':');
                    final surahNum = int.tryParse(parts.first) ?? 1;
                    final surah = repo.getSurahByNumber(surahNum);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: DuyaCard(
                        onTap: () => context.push('/content/quran/surah/$surahNum'),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.bookmark,
                            color: DuyaColors.desertGold,
                          ),
                          title: Text('${surah.nameEnglish} ($key)'),
                          subtitle: Text(surah.meaningEnglish),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    );
                  }).toList(),
          ),
        ],
      ),
    );
  }
}
