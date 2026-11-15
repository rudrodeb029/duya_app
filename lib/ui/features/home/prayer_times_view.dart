import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../../domain/models/prayer_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Astronomical Prayer Times schedule with city picker, calculation method,
/// Hijri date, and per-prayer smart reminder toggles.
class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<PrayerRitualRepository>();
    final schedule = repo.getSchedule();

    return DuyaSubpageScaffold(
      title: isArabic ? 'مواقيت الصلاة' : 'Prayer Times',
      actions: [
        DuyaCircleActionButton(
          icon: Icons.explore_outlined,
          tooltip: 'Qibla Compass',
          onTap: () => context.push('/qibla'),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaDaylightBannerCard(
            imageAsset: 'assets/images/live_mosque_day.jpg',
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F3EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: DuyaColors.emerald,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${schedule.location.localizedCity(isArabic)}, ${schedule.location.countryName}',
                            style: const TextStyle(
                              color: Color(0xFF136048),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: DuyaColors.desertGoldSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        schedule.hijriLabel,
                        style: const TextStyle(
                          color: DuyaColors.emerald,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Next: ${schedule.nextPrayer.localizedTitle(isArabic)}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat.jm().format(schedule.nextPrayer.time),
                  style: const TextStyle(
                    color: Color(0xFF10553F),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pause and reset your heart in prayer.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // City Selector Chips
          DuyaSectionHeader(
            title: 'City & Calculation',
            subtitle: 'Select location for local solar calculation',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: PrayerRitualRepository.availableLocations.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final loc = PrayerRitualRepository.availableLocations[index];
                final selected = loc.id == repo.selectedLocation.id;
                return ChoiceChip(
                  label: Text(loc.localizedCity(isArabic)),
                  selected: selected,
                  onSelected: (_) => repo.selectLocation(loc),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<PrayerCalcMethod>(
            initialValue: repo.method,
            decoration: const InputDecoration(
              labelText: 'Calculation Method',
              prefixIcon: Icon(Icons.tune),
            ),
            items: const [
              DropdownMenuItem(
                value: PrayerCalcMethod.ummAlQura,
                child: Text('Umm Al-Qura University, Makkah'),
              ),
              DropdownMenuItem(
                value: PrayerCalcMethod.muslimWorldLeague,
                child: Text('Muslim World League'),
              ),
              DropdownMenuItem(
                value: PrayerCalcMethod.isna,
                child: Text('ISNA (North America)'),
              ),
              DropdownMenuItem(
                value: PrayerCalcMethod.egyptian,
                child: Text('Egyptian General Authority'),
              ),
              DropdownMenuItem(
                value: PrayerCalcMethod.karachi,
                child: Text('University of Islamic Sciences, Karachi'),
              ),
            ],
            onChanged: (m) {
              if (m != null) repo.selectMethod(m);
            },
          ),
          const SizedBox(height: 20),
          ...schedule.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                color: entry.isNext ? DuyaColors.desertGoldSoft : null,
                child: Row(
                  children: [
                    Icon(
                      entry.isNext ? Icons.notifications_active : Icons.wb_sunny_outlined,
                      color: entry.isNext ? DuyaColors.emerald : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.localizedTitle(isArabic),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                            ),
                          ),
                          if (entry.isNext)
                            const Text(
                              'Upcoming Prayer',
                              style: TextStyle(
                                color: DuyaColors.emerald,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat.jm().format(entry.time),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => repo.togglePrayerAlert(entry.name),
                      icon: Icon(
                        entry.notificationEnabled
                            ? Icons.volume_up_outlined
                            : Icons.volume_off_outlined,
                        color: entry.notificationEnabled
                            ? DuyaColors.emerald
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
