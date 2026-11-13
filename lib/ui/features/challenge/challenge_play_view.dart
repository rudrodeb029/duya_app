import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';
import 'challenge_shell_view.dart';

/// Play Hub: Choose one of the 4 illustrated Doors (Prophet's, Qur'an, Makkah, Madinah).
class ChallengePlayView extends StatelessWidget {
  const ChallengePlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final challenge = context.watch<ChallengeRepository>();
    final auth = context.watch<AuthProfileRepository>();

    return ChallengeScaffold(
      currentIndex: 0,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Start the challenge',
            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose a door',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: challenge.doors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final door = challenge.doors[index];
              return DuyaCard(
                onTap: () => _handleDoorTap(context, door.id, auth, challenge),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomPaint(
                        size: const Size(120, 145),
                        painter: ChallengeDoorPainter(
                          doorColor: Color(door.colorHex),
                          variantIndex: index,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      door.localizedTitle(auth.isArabic),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      door.subtitleEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleDoorTap(
    BuildContext context,
    String doorId,
    AuthProfileRepository auth,
    ChallengeRepository challenge,
  ) async {
    if (challenge.keysCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No keys left today — redeem code DUYA2026 in Keys!'),
        ),
      );
      context.go('/challenge/keys');
      return;
    }

    if (auth.profile.nationality == null) {
      final proceed = await _showCompleteInfoSheet(context, auth);
      if (!proceed || !context.mounted) return;
    }

    context.push('/challenge/quiz/$doorId');
  }

  Future<bool> _showCompleteInfoSheet(
    BuildContext context,
    AuthProfileRepository auth,
  ) async {
    var updated = false;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: DuyaColors.warningSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                color: DuyaColors.warning,
                size: 30,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Complete your information',
              style: Theme.of(ctx).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Update your nationality to be eligible for the Umrah Knowledge Challenge draw.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  final picked = await showNationalityPickerSheet(context);
                  if (picked != null) {
                    await auth.updateNationality(picked);
                    updated = true;
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Your information has been updated.'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Choose your nationality'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
    return updated;
  }
}
