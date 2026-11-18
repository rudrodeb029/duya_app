import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Persistent daylight header + 5-item bottom bar (`Play`, `Winners`, `Ilm`, `Share`, `Help`)
/// for the Knowledge Challenge experience.
class ChallengeScaffold extends StatelessWidget {
  const ChallengeScaffold({
    super.key,
    required this.currentIndex,
    required this.body,
    this.title,
  });

  final int currentIndex;
  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final ilmBalance = context.watch<ChallengeRepository>().ilmBalance;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DuyaDaylightBackground(
        child: Column(
          children: [
            DuyaDaylightHeader(
              title: title ??
                  switch (currentIndex) {
                    0 => 'Doors',
                    1 => 'Raffle',
                    2 => 'Ilm',
                    4 => 'Help',
                    _ => 'Challenge',
                  },
              showBack: true,
              onBack: () => context.go('/home'),
              actions: [
                DuyaIlmChip(
                  count: ilmBalance,
                  onTap: () => context.go('/challenge/ilm'),
                ),
              ],
            ),
            Expanded(child: body),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? DuyaColors.nightSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x140E523C),
              blurRadius: 18,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                _ChallengeNavItem.icon(
                  label: 'Play',
                  icon: Icons.door_front_door_outlined,
                  activeIcon: Icons.door_front_door,
                  selected: currentIndex == 0,
                  onTap: () => context.go('/challenge/play'),
                ),
                _ChallengeNavItem.icon(
                  label: 'Winners',
                  icon: Icons.emoji_events_outlined,
                  activeIcon: Icons.emoji_events,
                  selected: currentIndex == 1,
                  onTap: () => context.go('/challenge/winners'),
                ),
                _ChallengeNavItem(
                  label: 'Ilm',
                  selected: currentIndex == 2,
                  onTap: () => context.go('/challenge/ilm'),
                  iconBuilder: (selected) => IlmIcon(
                    size: 22,
                    color: selected
                        ? const Color(0xFFC79A3C)
                        : const Color(0xFF7A8C85),
                  ),
                ),
                _ChallengeNavItem.icon(
                  label: 'Share',
                  icon: Icons.share_outlined,
                  activeIcon: Icons.share,
                  selected: currentIndex == 3,
                  onTap: () => _showShareSheet(context),
                ),
                _ChallengeNavItem.icon(
                  label: 'Help',
                  icon: Icons.support_agent_outlined,
                  activeIcon: Icons.support_agent,
                  selected: currentIndex == 4,
                  onTap: () => context.go('/challenge/help'),
                ),
              ],
            ),
          ),
        ),
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
              'Share code DUYA2026 with friends & family. Every friend who enters earns you +${ChallengeRepository.ilmReferralReward} Ilm!',
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
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
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

class _ChallengeNavItem extends StatelessWidget {
  const _ChallengeNavItem({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.iconBuilder,
  });

  factory _ChallengeNavItem.icon({
    required String label,
    required IconData icon,
    required IconData activeIcon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return _ChallengeNavItem(
      label: label,
      selected: selected,
      onTap: onTap,
      iconBuilder: (isSelected) => Builder(
        builder: (context) => Icon(
          isSelected ? activeIcon : icon,
          size: 24,
          color: isSelected
              ? DuyaColors.emerald
              : Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget Function(bool selected) iconBuilder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        label: label,
        button: true,
        selected: selected,
        child: Tooltip(
          message: label,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  iconBuilder(selected),
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2.5,
                    width: selected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: DuyaColors.emerald,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
