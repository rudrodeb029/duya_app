import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Challenge Intro screen explaining daily keys, referrals & draw entry rules.
class ChallengeIntroView extends StatelessWidget {
  const ChallengeIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Umrah Knowledge Challenge')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 48).clamp(
                  0.0,
                  double.infinity,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: const BoxDecoration(
                          color: DuyaColors.desertGoldSoft,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.vpn_key_rounded,
                          size: 44,
                          color: DuyaColors.desertGold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Every key = a chance to enter',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const _RuleRow(
                        icon: Icons.vpn_key_outlined,
                        title: 'A key for every day',
                        desc:
                            'You receive one complimentary key at the start of each day.',
                      ),
                      const SizedBox(height: 12),
                      const _RuleRow(
                        icon: Icons.share_outlined,
                        title: 'Share & collect keys',
                        desc:
                            'Invite family and friends — each friend who joins earns you another key.',
                      ),
                      const SizedBox(height: 12),
                      const _RuleRow(
                        icon: Icons.check_circle_outline,
                        title: 'Answer correctly & enter',
                        desc:
                            'Unlock a door and answer accurately to enter today’s Umrah & Zamzam draw.',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Terms & Conditions'),
                              content: const Text(
                                'Participation in the Duya Knowledge Challenge is completely free. Daily draws are open to eligible users with completed nationality details.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'By proceeding, you agree to Terms & Conditions',
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.go('/challenge/play'),
                          child: const Text('Play Now'),
                        ),
                      ),
                    ],
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

class _RuleRow extends StatelessWidget {
  const _RuleRow({
    required this.icon,
    required this.title,
    required this.desc,
  });

  final IconData icon;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return DuyaCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: DuyaColors.emerald),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(desc, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
