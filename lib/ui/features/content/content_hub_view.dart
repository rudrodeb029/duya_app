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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DuyaDaylightBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DuyaDaylightHeader(
                title: isArabic ? 'مركز المحتوى' : 'Content',
                showBack: true,
                showLogo: false,
              actions: [
                DuyaCircleActionButton(
                  icon: Icons.person,
                  tooltip: 'Profile',
                  onTap: () => context.push('/profile'),
                ),
              ],
              bottom: Row(
                children: [
                  DuyaHeaderQuickTile(
                    icon: Icons.access_time,
                    label: s.prayerTimes,
                    onTap: () => context.push('/prayer-times'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.menu_book_rounded,
                    label: s.quran,
                    onTap: () => context.push('/content/quran'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.volunteer_activism_outlined,
                    label: s.duas,
                    onTap: () => context.push('/content/duas'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.explore_outlined,
                    label: s.qibla,
                    onTap: () => context.push('/qibla'),
                  ),
                ],
              ),
            ),
          ),
          // Live Haramain Broadcasts
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: DuyaSectionHeader(
                title: isArabic ? 'البث المباشر للحرمين' : 'Live from Al-Haramain',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 146,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: repo.liveChannels.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final ch = repo.liveChannels[index];
                  return SizedBox(
                    width: 248,
                    child: DuyaDaylightBannerCard(
                      imageAsset: 'assets/images/live_mosque_day.jpg',
                      onTap: () => context.push('/content/live/${ch.id}'),
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD62B2B),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle, size: 6, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'LIVE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 8.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 162),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ch.titleEn,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF10553F),
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  ch.mosqueName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                    fontSize: 9.8,
                                  ),
                                ),
                              ],
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
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(
                'Explore by Topic',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  for (final topic in [
                    'All',
                    'Rituals',
                    'Hajj',
                    'Manasik',
                    'Reflections',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Text(
                          topic,
                          style: const TextStyle(fontSize: 10.5),
                        ),
                        selected: _selectedTopic == topic,
                        onSelected: (_) =>
                            setState(() => _selectedTopic = topic),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Holy Qur'an Reciters Shelf
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: DuyaSectionHeader(
                title: 'Holy Qur’an',
                onActionTap: () => context.push('/content/quran'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: repo.reciters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final reciter = repo.reciters[index];
                  return SizedBox(
                    width: 188,
                    child: DuyaCard(
                      padding: const EdgeInsets.all(12),
                      onTap: () =>
                          context.push('/content/quran?reciter=${reciter.id}'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(0xFFE7F3EE),
                                child: Icon(
                                  Icons.record_voice_over,
                                  color: DuyaColors.emerald,
                                  size: 15,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: DuyaColors.desertGoldSoft,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.volume_up,
                                  color: DuyaColors.emerald,
                                  size: 13,
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
                              fontSize: 11.2,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${reciter.surahCount} Surahs • ${reciter.style}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 9.5),
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
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            sliver: SliverToBoxAdapter(
              child: DuyaCard(
                padding: const EdgeInsets.all(12),
                onTap: () => context.push('/content/duas'),
                color: DuyaColors.desertGoldSoft,
                child: const Row(
                  children: [
                    Icon(
                      Icons.volunteer_activism_outlined,
                      color: DuyaColors.emerald,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duas & Daily Athkar',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11.8,
                              color: DuyaColors.textPrimaryLight,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Authentic supplications with built-in Tasbih counter',
                            style: TextStyle(
                              fontSize: 9.8,
                              color: DuyaColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: DuyaColors.emerald,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Rituals, Hajj Journey, Manasik & Reflections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: DuyaSectionHeader(
                title: 'Rituals, Hajj & Reflections',
                onActionTap: () => context.push('/content/articles'),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.separated(
              itemCount: filteredArticles.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final art = filteredArticles[index];
                return DuyaCard(
                  padding: const EdgeInsets.all(11),
                  onTap: () => context.push('/content/articles/${art.id}'),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F3EE),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(
                          art.mediaKind == 'audio'
                              ? Icons.headphones
                              : art.mediaKind == 'video'
                                  ? Icons.play_circle_outline
                                  : Icons.article_outlined,
                          color: DuyaColors.emerald,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              art.topic.toUpperCase(),
                              style: const TextStyle(
                                color: DuyaColors.desertGold,
                                fontSize: 8.8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              art.titleEn,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11.2,
                              ),
                            ),
                            Text(
                              '${art.speakerOrAuthor} • ${art.durationOrReadTime}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 9.8),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}
