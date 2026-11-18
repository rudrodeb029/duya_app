import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';
import 'challenge_shell_view.dart';

/// Challenge Ilm screen: knowledge reward balance, seeker level progress,
/// how Ilm is earned & spent, and invite-code redemption.
class ChallengeIlmView extends StatefulWidget {
  const ChallengeIlmView({super.key});

  @override
  State<ChallengeIlmView> createState() => _ChallengeIlmViewState();
}

class _ChallengeIlmViewState extends State<ChallengeIlmView> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();
    final toNext = repo.ilmToNextLevel;
    final levels = ChallengeRepository.ilmLevels;
    final currentIdx = levels.lastIndexWhere(
      (l) => repo.lifetimeIlm >= l.threshold,
    );
    final nextThreshold =
        currentIdx + 1 < levels.length ? levels[currentIdx + 1].threshold : null;
    final currentThreshold = levels[currentIdx].threshold;
    final progress = nextThreshold == null
        ? 1.0
        : (repo.lifetimeIlm - currentThreshold) /
            (nextThreshold - currentThreshold);

    return ChallengeScaffold(
      currentIndex: 2,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Knowledge rewards',
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Your Ilm',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          // Balance hero card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0E4A38), Color(0xFF16634B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: DuyaCard.lightShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IlmIcon(size: 32, color: Color(0xFFE2C378)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ChallengeRepository.formatIlm(repo.ilmBalance)} Ilm',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          Text(
                            '${repo.ilmLevel} (${currentIdx + 1}/${levels.length})',
                            style: const TextStyle(
                              color: Color(0xFFE2C378),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 5,
                    backgroundColor: Colors.white.withValues(alpha: 0.18),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFE2C378)),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  toNext == null
                      ? 'Highest level (${levels.length}/${levels.length}) reached — MashaAllah!'
                      : '${ChallengeRepository.formatIlm(toNext)} Ilm to reach ${levels[currentIdx + 1].title}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 9.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Today stats
          Row(
            children: [
              _StatTile(
                label: 'Earned today',
                value: '+${ChallengeRepository.formatIlm(repo.ilmEarnedToday)}',
              ),
              const SizedBox(width: 8),
              _StatTile(
                label: 'Doors opened',
                value: '${repo.completedDoorsCount}/${repo.doors.length}',
              ),
              const SizedBox(width: 8),
              _StatTile(
                label: 'Draw entries',
                value: '${repo.drawEntriesCount}',
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'How Ilm works',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          const DuyaCard(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              children: [
                _RuleTile(
                  icon: Icons.wb_sunny_outlined,
                  title: 'Daily gift',
                  subtitle: 'Start each day with Ilm to open doors.',
                  amount: '+${ChallengeRepository.dailyIlmGift}',
                ),
                _RuleTile(
                  icon: Icons.door_front_door_outlined,
                  title: 'Open a door',
                  subtitle: 'All 8 doors are open to play every day.',
                  amount: 'Free',
                ),
                _RuleTile(
                  icon: Icons.check_circle_outline,
                  title: 'Correct answer',
                  subtitle: 'Earn Ilm plus an entry into today’s draw.',
                  amount: '+${ChallengeRepository.ilmCorrectReward}',
                ),
                _RuleTile(
                  icon: Icons.cancel_outlined,
                  title: 'Incorrect answer',
                  subtitle: 'Wrong answers deduct Ilm from your balance.',
                  amount: '−${ChallengeRepository.ilmWrongPenalty}',
                  isCost: true,
                ),
                _RuleTile(
                  icon: Icons.share_outlined,
                  title: 'Invite a friend',
                  subtitle: 'Share your unique invite code with family.',
                  amount: '+${ChallengeRepository.ilmReferralReward}',
                  showDivider: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _codeController,
            style: const TextStyle(fontSize: 11.0),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              hintText: 'Add friend’s invite code (e.g. DUYA-XXXXXX)',
              hintStyle: TextStyle(fontSize: 10.5),
              prefixIcon: Icon(Icons.confirmation_number_outlined, size: 18),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 38),
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            ),
            onPressed: () {
              final ownCode =
                  context.read<AuthProfileRepository>().inviteCode;
              final res = repo.redeemCode(
                _codeController.text,
                ownInviteCode: ownCode,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(res.message)),
              );
              if (res.success) _codeController.clear();
            },
            child: const Text(
              'Check the code',
              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DuyaCard(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: DuyaColors.emerald,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 9.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isCost = false,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCost;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFE7EFEA)))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F3EE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: DuyaColors.emerald, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.8,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 9.5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const IlmIcon(size: 10, color: Color(0xFFC79A3C)),
                const SizedBox(width: 4),
                Text(
                  amount,
                  style: TextStyle(
                    color: isCost
                        ? DuyaColors.textSecondaryLight
                        : DuyaColors.emerald,
                    fontSize: 9.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
