import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Challenge Intro screen explaining daily Ilm, referrals & draw entry rules.
class ChallengeIntroView extends StatelessWidget {
  const ChallengeIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return DuyaSubpageScaffold(
      title: 'Umrah Knowledge Challenge',
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 28).clamp(
                  0.0,
                  double.infinity,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DuyaDaylightBannerCard(
                        imageAsset: 'assets/images/challenge_kaaba_day.jpg',
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: DuyaColors.desertGoldSoft,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Daily Draw Entry',
                                      style: TextStyle(
                                        color: DuyaColors.emerald,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Every Ilm = a door to knowledge & draw entry',
                                    style: TextStyle(
                                      color: Color(0xFF10553F),
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w800,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 80),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _RuleRow(
                        leading: IlmIcon(
                          size: 22,
                          color: DuyaColors.desertGold,
                        ),
                        title: 'Daily Ilm gift',
                        desc:
                            'You receive 2 complimentary Ilm at the start of each day to unlock doors.',
                      ),
                      const SizedBox(height: 12),
                      const _RuleRow(
                        leading: Icon(
                          Icons.share_outlined,
                          color: DuyaColors.emerald,
                        ),
                        title: 'Share & earn Ilm',
                        desc:
                            'Invite family and friends — each friend who joins rewards you +3 Ilm.',
                      ),
                      const SizedBox(height: 12),
                      const _RuleRow(
                        leading: Icon(
                          Icons.check_circle_outline,
                          color: DuyaColors.emerald,
                        ),
                        title: 'Answer correctly & earn rewards',
                        desc:
                            'Spend 1 Ilm to unlock a door. Earn +2 Ilm & a draw entry when right, or +1 Ilm for learning.',
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
    required this.leading,
    required this.title,
    required this.desc,
  });

  final Widget leading;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return DuyaCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24, height: 24, child: Center(child: leading)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
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
