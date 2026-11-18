import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Duas & Athkar Hub — centerpiece for `duya_app` with categories, search & favorites.
class DuasHubView extends StatefulWidget {
  const DuasHubView({super.key});

  @override
  State<DuasHubView> createState() => _DuasHubViewState();
}

class _DuasHubViewState extends State<DuasHubView> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final auth = context.watch<AuthProfileRepository>();

    final matchingDuas = _query.trim().isEmpty
        ? const []
        : repo.allDuas
            .where((d) =>
                d.titleEn.toLowerCase().contains(_query.toLowerCase()) ||
                d.translationEn.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return DuyaSubpageScaffold(
      title: 'Duas',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: DuyaColors.emerald),
              hintText: 'Search duas (Tawaf, Istighfar, Travel...)',
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 18),
          if (matchingDuas.isNotEmpty) ...[
            Text(
              'Search Results (${matchingDuas.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...matchingDuas.map(
              (d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DuyaCard(
                  onTap: () => context.push('/content/duas/${d.categoryId}'),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(d.localizedTitle(auth.isArabic)),
                    subtitle: Text(d.reference),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ),
          ] else ...[
            if (auth.favoriteDuaIds.isNotEmpty) ...[
              Text(
                'Saved Favorites (${auth.favoriteDuaIds.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ...repo.allDuas
                  .where((d) => auth.favoriteDuaIds.contains(d.id))
                  .map(
                    (d) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: DuyaCard(
                        color: DuyaColors.desertGoldSoft,
                        onTap: () =>
                            context.push('/content/duas/${d.categoryId}'),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: DuyaColors.emerald,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                d.localizedTitle(auth.isArabic),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: DuyaColors.textPrimaryLight,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                color: DuyaColors.emerald),
                          ],
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
            ],
            Text(
              'Browse Collections',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...repo.duaCategories.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DuyaCard(
                  onTap: () => context.push('/content/duas/${cat.id}'),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F3EE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.volunteer_activism,
                          color: DuyaColors.emerald,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cat.localizedTitle(auth.isArabic),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              cat.subtitleEn,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
