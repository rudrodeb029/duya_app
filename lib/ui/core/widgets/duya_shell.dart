import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../localization/app_strings.dart';
import '../theme/duya_colors.dart';

/// Persistent 5-slot navigation shell: 4 stateful tabs (Home, Journey, Content,
/// Market) plus the signature floating Duya AI companion pill button.
class DuyaShell extends StatelessWidget {
  const DuyaShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final s = AppStrings(isArabic: isArabic);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final current = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? DuyaColors.nightSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF14634C).withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
            child: Row(
              children: [
                _NavTabItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: s.navHome,
                  selected: current == 0,
                  onTap: () => _goBranch(0),
                ),
                _NavTabItem(
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore,
                  label: s.navJourney,
                  selected: current == 1,
                  onTap: () => _goBranch(1),
                ),
                _NavTabItem(
                  icon: Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  label: s.navContent,
                  selected: current == 2,
                  onTap: () => _goBranch(2),
                ),
                _NavTabItem(
                  icon: Icons.storefront_outlined,
                  activeIcon: Icons.storefront,
                  label: s.navMarket,
                  selected: current == 3,
                  onTap: () => _goBranch(3),
                ),
                const SizedBox(width: 6),
                _AiCompanionPill(
                  label: s.navAi,
                  onTap: () => context.push('/ai'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTabItem extends StatelessWidget {
  const _NavTabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = DuyaColors.emerald;
    final inactiveColor = Theme.of(context).textTheme.bodyMedium?.color;

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
                  Icon(
                    selected ? activeIcon : icon,
                    color: selected ? activeColor : inactiveColor,
                    size: 24,
                  ),
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2.5,
                    width: selected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: activeColor,
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

class _AiCompanionPill extends StatelessWidget {
  const _AiCompanionPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E513C), Color(0xFF1C7557)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF14634C).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(26),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(26),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
