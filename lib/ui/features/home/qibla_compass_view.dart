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

    return Scaffold(
      appBar: AppBar(title: Text(isArabic ? 'اتجاه القبلة' : 'Qibla Compass')),
      body: Padding(
        padding: const EdgeInsets.all(24),
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
                  Chip(
                    label: Text('${qiblaDeg.toStringAsFixed(1)}° N'),
                    backgroundColor: DuyaColors.desertGoldSoft,
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Compass Dial
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: DuyaColors.celestialHeroGradient,
                border: Border.all(
                  color: aligned ? DuyaColors.success : DuyaColors.desertGold,
                  width: 4,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 16,
                    child: Text(
                      'N',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    child: Text('S', style: TextStyle(color: Colors.white54)),
                  ),
                  const Positioned(
                    left: 18,
                    child: Text('W', style: TextStyle(color: Colors.white54)),
                  ),
                  const Positioned(
                    right: 18,
                    child: Text('E', style: TextStyle(color: Colors.white54)),
                  ),
                  Transform.rotate(
                    angle: relativeAngleRad,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.navigation,
                          size: 62,
                          color: aligned
                              ? DuyaColors.success
                              : DuyaColors.desertGold,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'KAABA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
              style: TextStyle(fontSize: 12),
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
