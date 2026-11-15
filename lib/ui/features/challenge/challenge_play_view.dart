import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/challenge_repository.dart';
import '../../../domain/models/challenge_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';
import 'challenge_shell_view.dart';

/// Play Hub: Choose one of the 8 illustrated Doors (Seerah, Qur'an, Makkah,
/// Madinah, Umrah, Hajj, Prayer & Qibla, Duas & Zamzam).
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
          Text(
            'Start the challenge',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Choose a door',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: challenge.doors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.76,
            ),
            itemBuilder: (context, index) {
              final door = challenge.doors[index];
              final exhausted = challenge.isDoorExhaustedToday(door.id);
              final joined = challenge.isDoorJoined(door.id);
              final answered = challenge.answeredCountToday(door.id);
              final dailyTotal = challenge.dailyQuestionsForDoor(door.id).length;
              final accentColor = Color(door.colorHex);
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return DuyaCard(
                borderRadius: 8,
                color: Colors.transparent,
                padding: EdgeInsets.zero,
                onTap: () => _handleDoorTap(context, door.id, auth, challenge),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            accentColor.withValues(alpha: isDark ? 0.14 : 0.045),
                            Colors.transparent,
                            DuyaColors.desertGold.withValues(alpha: 0.04),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DoorIslamicBorderPainter(
                          style: _borderStyleFor(door.theme),
                          accentColor: accentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 13, 13, 14),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      door.calligraphyAr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: DuyaTypography.arabicScript(
                                        fontSize: 13.5,
                                        height: 1.15,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? const Color(0xFFE2C378)
                                            : accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: (exhausted || joined)
                                      ? DuyaColors.successSoft
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: exhausted
                                    ? const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle_rounded,
                                            size: 11,
                                            color: DuyaColors.emerald,
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            'Completed',
                                            style: TextStyle(
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w700,
                                              color: DuyaColors.emerald,
                                            ),
                                          ),
                                        ],
                                      )
                                    : answered > 0
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                joined
                                                    ? Icons.check_circle_rounded
                                                    : Icons.timelapse_rounded,
                                                size: 11,
                                                color: joined
                                                    ? DuyaColors.emerald
                                                    : DuyaColors.desertGold,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                '$answered/$dailyTotal',
                                                style: TextStyle(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: joined
                                                      ? DuyaColors.emerald
                                                      : (isDark
                                                          ? DuyaColors
                                                              .textPrimaryDark
                                                          : const Color(
                                                              0xFF10553F,
                                                            )),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const IlmIcon(
                                                size: 11,
                                                color: DuyaColors.desertGold,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                '${ChallengeRepository.ilmPerDoor} Ilm',
                                                style: TextStyle(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: isDark
                                                      ? DuyaColors
                                                          .textPrimaryDark
                                                      : const Color(0xFF10553F),
                                                ),
                                              ),
                                            ],
                                          ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                door.imageAsset,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            door.localizedTitle(auth.isArabic),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
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

  DoorBorderStyle _borderStyleFor(DoorTheme theme) => switch (theme) {
        DoorTheme.prophet => DoorBorderStyle.nabawiLattice,
        DoorTheme.quran => DoorBorderStyle.quranMushaf,
        DoorTheme.makkah => DoorBorderStyle.makkahKiswah,
        DoorTheme.madinah => DoorBorderStyle.madinahDome,
        DoorTheme.umrah => DoorBorderStyle.umrahWaves,
        DoorTheme.hajj => DoorBorderStyle.hajjSunburst,
        DoorTheme.prayer => DoorBorderStyle.prayerMihrab,
        DoorTheme.duas => DoorBorderStyle.duasTasbih,
      };

  Future<void> _handleDoorTap(
    BuildContext context,
    String doorId,
    AuthProfileRepository auth,
    ChallengeRepository challenge,
  ) async {
    if (challenge.isDoorExhaustedToday(doorId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You completed all 100 questions for this door today! Come back tomorrow for the next 100 questions.',
          ),
        ),
      );
      return;
    }

    if (!challenge.isDoorCompleted(doorId) &&
        challenge.ilmBalance < ChallengeRepository.ilmPerDoor) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough Ilm today — redeem DUYA2026 in Ilm!'),
        ),
      );
      context.go('/challenge/ilm');
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
