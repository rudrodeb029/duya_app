import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';

/// Persistent header + 5-item bottom bar (`Play`, `Winners`, `Keys`, `Share`, `Help`)
/// for the Knowledge Challenge experience.
class ChallengeScaffold extends StatelessWidget {
  const ChallengeScaffold({
    super.key,
    required this.currentIndex,
    required this.body,
  });

  final int currentIndex;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final keysCount = context.watch<ChallengeRepository>().keysCount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Knowledge Challenge'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: DuyaColors.desertGoldSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.vpn_key_outlined,
                  size: 16,
                  color: DuyaColors.emerald,
                ),
                const SizedBox(width: 6),
                Text(
                  '$keysCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: DuyaColors.emerald,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (idx) {
          switch (idx) {
            case 0:
              context.go('/challenge/play');
            case 1:
              context.go('/challenge/winners');
            case 2:
              context.go('/challenge/keys');
            case 3:
              _showShareSheet(context);
            case 4:
              context.go('/challenge/help');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.door_front_door_outlined),
            label: 'Play',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Winners',
          ),
          NavigationDestination(
            icon: Icon(Icons.vpn_key_outlined),
            label: 'Keys',
          ),
          NavigationDestination(
            icon: Icon(Icons.share_outlined),
            label: 'Share',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Help',
          ),
        ],
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.share, size: 42, color: DuyaColors.emerald),
            const SizedBox(height: 12),
            Text(
              'Share Invite Code',
              style: Theme.of(ctx).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Share code DUYA2026 with friends & family. Every friend who enters earns you +1 Key!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: DuyaColors.desertGoldSoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'DUYA2026',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: DuyaColors.emerald,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invite code DUYA2026 ready to share!')),
                  );
                },
                child: const Text('Copy Invite Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
