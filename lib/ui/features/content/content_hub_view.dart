import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../core/localization/app_strings.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Content Hub tab: quick worship links, Live Haramain streams, topic chips,
/// Holy Qur'an reciter cards, Rituals, Hajj Journey, Manasik, and Reflections.
class ContentHubView extends StatefulWidget {
  const ContentHubView({super.key});

  @override
  State<ContentHubView> createState() => _ContentHubViewState();
}

class _ContentHubViewState extends State<ContentHubView> {
  String _selectedTopic = 'All';

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final s = AppStrings(isArabic: isArabic);
    final repo = context.read<ContentRepository>();

    final filteredArticles = _selectedTopic == 'All'
        ? repo.ritualArticles
        : repo.ritualArticles
            .where((a) => a.topic == _selectedTopic)
            .toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              gradient: DuyaColors.emeraldGoldGradient,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const DuyaLogoBadge(
                          size: 30,
                          color: DuyaColors.desertGoldSoft,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isArabic ? 'مركز المحتوى' : 'Content Hub',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => context.push('/profile'),
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ContentHeaderTile(
                          icon: Icons.access_time,
                          label: s.prayerTimes,
                          onTap: () => context.push('/prayer-times'),
                        ),
                        _ContentHeaderTile(
                          icon: Icons.menu_book_rounded,
                          label: s.quran,
                          onTap: () => context.push('/content/quran'),
                        ),
                        _ContentHeaderTile(
                          icon: Icons.volunteer_activism_outlined,
                          label: s.duas,
                          onTap: () => context.push('/content/duas'),
                        ),
                        _ContentHeaderTile(
                          icon: Icons.explore_outlined,
                          label: s.qibla,
                          onTap: () => context.push('/qibla'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Live Haramain Broadcasts
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: DuyaSectionHeader(
              title: isArabic ? 'البث المباشر للحرمين' : 'Live from Al-Haramain',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 188,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: repo.liveChannels.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final ch = repo.liveChannels[index];
                return InkWell(
                  onTap: () => context.push('/content/live/${ch.id}'),
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 270,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Color(ch.accentHex),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: DuyaColors.error.withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Text(
                                'Live •',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.podcasts,
                              color: DuyaColors.desertGoldSoft,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          ch.titleEn,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ch.mosqueName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Explore by Topic
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
            child: Text(
              'Explore by Topic',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final topic in [
                  'All',
                  'Rituals',
                  'Hajj',
                  'Manasik',
                  'Reflections',
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(topic),
                      selected: _selectedTopic == topic,
                      onSelected: (_) => setState(() => _selectedTopic = topic),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Holy Qur'an Reciters Shelf
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: DuyaSectionHeader(
              title: 'Holy Qur’an',
              onActionTap: () => context.push('/content/quran'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 205,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: repo.reciters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final reciter = repo.reciters[index];
                return InkWell(
                  onTap: () => context.push('/content/quran?reciter=${reciter.id}'),
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 210,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(reciter.accentHex),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.2),
                              child: const Icon(
                                Icons.record_voice_over,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x38155E49),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          reciter.titleEn,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${reciter.surahCount} Surahs • ${reciter.style}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Duas & Athkar Spotlight
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
          sliver: SliverToBoxAdapter(
            child: DuyaCard(
              onTap: () => context.push('/content/duas'),
              color: DuyaColors.desertGoldSoft,
              child: const Row(
                children: [
                  Icon(
                    Icons.volunteer_activism_outlined,
                    color: DuyaColors.emerald,
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Duas & Daily Athkar',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: DuyaColors.textPrimaryLight,
                          ),
                        ),
                        Text(
                          'Authentic supplications with built-in Tasbih counter',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: DuyaColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: DuyaColors.emerald),
                ],
              ),
            ),
          ),
        ),
        // Rituals, Hajj Journey, Manasik & Reflections
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
            child: DuyaSectionHeader(
              title: 'Rituals, Hajj & Reflections',
              onActionTap: () => context.push('/content/articles'),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
          sliver: SliverList.separated(
            itemCount: filteredArticles.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final art = filteredArticles[index];
              return DuyaCard(
                onTap: () => context.push('/content/articles/${art.id}'),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        art.mediaKind == 'audio'
                            ? Icons.headphones
                            : art.mediaKind == 'video'
                                ? Icons.play_circle_outline
                                : Icons.article_outlined,
                        color: DuyaColors.emerald,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            art.topic.toUpperCase(),
                            style: const TextStyle(
                              color: DuyaColors.desertGold,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            art.titleEn,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${art.speakerOrAuthor} • ${art.durationOrReadTime}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderTile extends StatelessWidget {
  const _ContentHeaderTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
