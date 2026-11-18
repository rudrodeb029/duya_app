import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Challenge Intro screen explaining daily Ilm, referrals & draw entry rules.
class ChallengeIntroView extends StatefulWidget {
  const ChallengeIntroView({super.key});

  @override
  State<ChallengeIntroView> createState() => _ChallengeIntroViewState();
}

class _ChallengeIntroViewState extends State<ChallengeIntroView> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return DuyaSubpageScaffold(
      title: 'Challenge',
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Every Ilm = a door to knowledge & draw entry',
                                    style: TextStyle(
                                      color: Color(0xFF10553F),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25,
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
                            'All 8 doors are open daily. Earn +0.125 Ilm & a draw entry when right, or -0.125 Ilm when wrong.',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: Checkbox(
                              value: _agreedToTerms,
                              onChanged: (val) => setState(
                                () => _agreedToTerms = val ?? false,
                              ),
                              activeColor: DuyaColors.emerald,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 4,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
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
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                'By proceeding, you agree to Terms & Conditions',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                          ),
                          onPressed: _agreedToTerms
                              ? () => context.go('/challenge/play')
                              : null,
                          child: const Text(
                            'Play Now',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 10.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
