import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';

/// Category Dua reader with Arabic text, transliteration, translation,
/// favorite toggle, and interactive Tasbih repetition counter per Dua.
class DuaDetailView extends StatefulWidget {
  const DuaDetailView({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<DuaDetailView> createState() => _DuaDetailViewState();
}

class _DuaDetailViewState extends State<DuaDetailView> {
  final Map<String, int> _counts = {};

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final auth = context.watch<AuthProfileRepository>();
    final category = repo.duaCategories.firstWhere(
      (c) => c.id == widget.categoryId,
      orElse: () => repo.duaCategories.first,
    );
    final duas = repo.getDuasForCategory(category.id);

    return Scaffold(
      appBar: AppBar(title: Text(category.localizedTitle(auth.isArabic))),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: duas.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final dua = duas[index];
          final currentCount = _counts[dua.id] ?? 0;
          final isFav = auth.favoriteDuaIds.contains(dua.id);
          final targetReached = currentCount >= dua.targetCount;

          return DuyaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dua.localizedTitle(auth.isArabic),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => auth.toggleFavoriteDua(dua.id),
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? DuyaColors.emerald : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  dua.arabicText,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: DuyaTypography.arabicScript(fontSize: 23),
                ),
                const SizedBox(height: 12),
                Text(
                  dua.transliteration,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  dua.translationEn,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      dua.reference,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: DuyaColors.emerald,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Reset count',
                      onPressed: () => setState(() => _counts[dua.id] = 0),
                      icon: const Icon(Icons.refresh, size: 18),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(
                        () => _counts[dua.id] = currentCount + 1,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: targetReached
                            ? DuyaColors.success
                            : DuyaColors.emerald,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Tasbih $currentCount / ${dua.targetCount}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
