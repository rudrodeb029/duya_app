import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import 'challenge_shell_view.dart';

/// Winners Leaderboard screen with Spotlight Winner & Today / Previous toggle.
class ChallengeWinnersView extends StatefulWidget {
  const ChallengeWinnersView({super.key});

  @override
  State<ChallengeWinnersView> createState() => _ChallengeWinnersViewState();
}

class _ChallengeWinnersViewState extends State<ChallengeWinnersView> {
  bool _showToday = true;

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();
    final spotlight = repo.winners.firstWhere((w) => w.isSpotlight);
    final list = repo.winners.where((w) => w.isToday == _showToday).toList();

    return ChallengeScaffold(
      currentIndex: 1,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Umrah Winner Spotlight',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          DuyaCard(
            color: DuyaColors.desertGoldSoft,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: DuyaColors.emerald,
                  child: Text(
                    spotlight.displayName.characters.first,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  spotlight.displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: DuyaColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Winner of an ${spotlight.prizeTitle} • ${spotlight.country}',
                  style: const TextStyle(
                    color: DuyaColors.emerald,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'List of winners',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Today')),
              ButtonSegment(value: false, label: Text('Previous winners')),
            ],
            selected: {_showToday},
            onSelectionChanged: (set) => setState(() => _showToday = set.first),
          ),
          const SizedBox(height: 14),
          ...list.map(
            (w) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Text(w.displayName.characters.first),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            w.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text('${w.prizeTitle} • ${w.dateLabel}'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14),
                              const SizedBox(width: 4),
                              Text(w.country, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
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
