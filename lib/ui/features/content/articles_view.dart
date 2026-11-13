import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Ritual Guides, Hajj Journey, Manasik & Reflections library list.
class ArticlesLibraryView extends StatefulWidget {
  const ArticlesLibraryView({super.key});

  @override
  State<ArticlesLibraryView> createState() => _ArticlesLibraryViewState();
}

class _ArticlesLibraryViewState extends State<ArticlesLibraryView> {
  String _topic = 'All';

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final items = _topic == 'All'
        ? repo.ritualArticles
        : repo.ritualArticles.where((a) => a.topic == _topic).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Rituals, Hajj & Manasik')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: ['All', 'Rituals', 'Hajj', 'Manasik', 'Reflections']
                .map(
                  (t) => ChoiceChip(
                    label: Text(t),
                    selected: _topic == t,
                    onSelected: (_) => setState(() => _topic = t),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (art) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DuyaCard(
                onTap: () => context.push('/content/articles/${art.id}'),
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
                    const SizedBox(height: 4),
                    Text(
                      art.titleEn,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${art.speakerOrAuthor} • ${art.durationOrReadTime}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full article/lecture reader view for a single Ritual or Hajj topic.
class ArticleDetailView extends StatelessWidget {
  const ArticleDetailView({super.key, required this.articleId});

  final String articleId;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final art = repo.ritualArticles.firstWhere(
      (a) => a.id == articleId,
      orElse: () => repo.ritualArticles.first,
    );

    return Scaffold(
      appBar: AppBar(title: Text(art.topic)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: DuyaColors.emeraldGoldGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  art.titleEn,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${art.speakerOrAuthor} • ${art.durationOrReadTime}',
                  style: const TextStyle(color: DuyaColors.desertGoldSoft),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            art.summary,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          Text(
            'Key Takeaways',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          ...art.keyPoints.map(
            (pt) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: DuyaColors.emerald,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(pt)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
