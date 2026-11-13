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

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'مواقيت الصلاة' : 'Prayer Times'),
        actions: [
          IconButton(
            tooltip: 'Qibla Compass',
            onPressed: () => context.push('/qibla'),
            icon: const Icon(Icons.explore_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: DuyaColors.celestialHeroGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: DuyaColors.desertGold, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '${schedule.location.localizedCity(isArabic)}, ${schedule.location.countryName}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const Spacer(),
                    Text(
                      schedule.hijriLabel,
                      style: const TextStyle(
                        color: DuyaColors.desertGoldSoft,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Next: ${schedule.nextPrayer.localizedTitle(isArabic)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.jm().format(schedule.nextPrayer.time),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Pause and reset your heart in prayer.',
                  style: TextStyle(color: Colors.white70, fontSize: 12.5),
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
                              fontSize: 16,
                            ),
                          ),
                          if (entry.isNext)
                            const Text(
                              'Upcoming Prayer',
                              style: TextStyle(
                                color: DuyaColors.emerald,
                                fontSize: 12,
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
                        fontSize: 16,
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
