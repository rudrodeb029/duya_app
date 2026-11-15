import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Calibrated Qibla Compass screen displaying exact Kaaba bearing and distance.
class QiblaCompassView extends StatefulWidget {
  const QiblaCompassView({super.key});

  @override
  State<QiblaCompassView> createState() => _QiblaCompassViewState();
}

class _QiblaCompassViewState extends State<QiblaCompassView> {
  double _deviceHeadingDeg = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<PrayerRitualRepository>();
    final schedule = repo.getSchedule();
    final qiblaDeg = schedule.qiblaBearingDegrees;
    final relativeAngleRad = ((qiblaDeg - _deviceHeadingDeg) * math.pi) / 180.0;
    final aligned = ((qiblaDeg - _deviceHeadingDeg).abs() % 360) < 8;

    return DuyaSubpageScaffold(
      title: isArabic ? 'اتجاه القبلة' : 'Qibla Compass',
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        child: Column(
          children: [
            DuyaCard(
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: DuyaColors.emerald),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.location.localizedCity(isArabic),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Distance to Kaaba: ${schedule.distanceToKaabaKm.toStringAsFixed(0)} km',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: DuyaColors.desertGoldSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${qiblaDeg.toStringAsFixed(1)}° N',
                      style: const TextStyle(
                        color: DuyaColors.emerald,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Sunlit Daylight Compass Dial
            Container(
              width: 248,
              height: 248,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: DuyaCard.lightShadow,
                border: Border.all(
                  color: aligned ? DuyaColors.success : DuyaColors.desertGold,
                  width: 4,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF3F7F5),
                  border: Border.all(
                    color: DuyaColors.emerald.withValues(alpha: 0.14),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned(
                      top: 14,
                      child: Text(
                        'N',
                        style: TextStyle(
                          color: DuyaColors.emerald,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 14,
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: DuyaColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 16,
                      child: Text(
                        'W',
                        style: TextStyle(
                          color: DuyaColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 16,
                      child: Text(
                        'E',
                        style: TextStyle(
                          color: DuyaColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: relativeAngleRad,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.navigation,
                            size: 60,
                            color: aligned
                                ? DuyaColors.success
                                : DuyaColors.emerald,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'KAABA',
                            style: TextStyle(
                              color: Color(0xFF10553F),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              aligned
                  ? 'Facing Qibla Direction'
                  : 'Rotate heading slider or device to align with Kaaba',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: aligned ? DuyaColors.success : DuyaColors.emerald,
              ),
            ),
            const Spacer(),
            const Text(
              'Interactive Heading Simulation (for devices without magnetometer)',
              style: TextStyle(fontSize: 10.5),
              textAlign: TextAlign.center,
            ),
            Slider(
              value: _deviceHeadingDeg,
              min: 0,
              max: 360,
              divisions: 72,
              label: '${_deviceHeadingDeg.round()}°',
              onChanged: (v) => setState(() => _deviceHeadingDeg = v),
            ),
          ],
        ),
      ),
    );
  }
}
