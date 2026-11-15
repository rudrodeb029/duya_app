import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../../domain/models/ritual_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';

/// Interactive Umrah Motawef companion with 6 ritual stages, live 7-lap
/// Tawaf & Sa'i counters, and authentic Arabic/English Duas.
class MotawefView extends StatelessWidget {
  const MotawefView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<PrayerRitualRepository>();
    final steps = repo.motawefSteps;
    final activeIdx = repo.activeMotawefStepIndex;
    final step = steps[activeIdx];

    return DuyaSubpageScaffold(
      title: isArabic ? 'دليل المطوّف' : 'Motawef Guide',
      headerBottom: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: steps.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final s = steps[index];
            final selected = index == activeIdx;
            return ChoiceChip(
              label: Text('${s.stepNumber}. ${s.phase.name.toUpperCase()}'),
              selected: selected,
              onSelected: (_) => repo.setActiveMotawefStep(index),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.localizedTitle(isArabic),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.summaryEn,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (step.hasLapCounter) ...[
                    const SizedBox(height: 18),
                    _LapCounterCard(step: step, repo: repo),
                  ],
                  const SizedBox(height: 18),
                  DuyaCard(
                    color: DuyaColors.desertGoldSoft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Recommended Supplication',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: DuyaColors.emerald,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step.duaArabic,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: DuyaTypography.arabicScript(
                            fontSize: 20,
                            color: DuyaColors.celestialNight,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step.duaTransliteration,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          step.duaTranslation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Checklist & Sunnah Reminders',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  ...step.checklist.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: DuyaCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: DuyaColors.emerald,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(point)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Row(
              children: [
                if (activeIdx > 0)
                  OutlinedButton(
                    onPressed: () => repo.setActiveMotawefStep(activeIdx - 1),
                    child: const Text('Previous'),
                  ),
                const Spacer(),
                ElevatedButton(
                  onPressed: activeIdx < steps.length - 1
                      ? () => repo.setActiveMotawefStep(activeIdx + 1)
                      : () => Navigator.of(context).pop(),
                  child: Text(
                    activeIdx < steps.length - 1 ? 'Next Ritual Step →' : 'Done',
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

class _LapCounterCard extends StatelessWidget {
  const _LapCounterCard({required this.step, required this.repo});

  final MotawefStep step;
  final PrayerRitualRepository repo;

  @override
  Widget build(BuildContext context) {
    final isTawaf = step.phase == MotawefPhase.tawaf;
    final count = isTawaf ? repo.tawafLap : repo.saiLap;

    return DuyaDaylightBannerCard(
      imageAsset: 'assets/images/challenge_kaaba_day.jpg',
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F3EE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isTawaf ? 'Tawaf Circuit Tracker' : "Sa'i Lap Tracker",
              style: const TextStyle(
                color: DuyaColors.emerald,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$count / 7',
            style: const TextStyle(
              color: Color(0xFF10553F),
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (i) {
              final done = i < count;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 24,
                height: 8,
                decoration: BoxDecoration(
                  color: done
                      ? DuyaColors.emerald
                      : DuyaColors.emerald.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: isTawaf ? repo.resetTawafLap : repo.resetSaiLap,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: count >= 7
                    ? null
                    : (isTawaf ? repo.incrementTawafLap : repo.incrementSaiLap),
                icon: const Icon(Icons.add),
                label: Text(count >= 7 ? 'Completed!' : 'Complete Lap'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
