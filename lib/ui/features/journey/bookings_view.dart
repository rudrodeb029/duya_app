import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Unified Bookings & Permits itinerary timeline.
class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final journeyRepo = context.watch<JourneyRepository>();
    final permitRepo = context.watch<PrayerRitualRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings & Permits')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (permitRepo.permitBookings.isNotEmpty) ...[
            Text(
              'Haram & Rawdah Permits',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...permitRepo.permitBookings.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DuyaCard(
                  color: DuyaColors.successSoft,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.qr_code_2,
                      color: DuyaColors.emerald,
                    ),
                    title: Text(p.slot.titleEn),
                    subtitle: Text(
                      '${p.slot.dateLabel} • ${p.slot.timeWindow}\nRef: ${p.permitCode}',
                    ),
                    trailing: Text(
                      p.status,
                      style: const TextStyle(
                        color: DuyaColors.emerald,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            'Travel & Experience Bookings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          ...journeyRepo.bookings.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DuyaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Chip(label: Text(b.type)),
                        const Spacer(),
                        Text(
                          b.status,
                          style: const TextStyle(
                            color: DuyaColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      b.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(b.subtitle),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'Ref: ${b.referenceCode} • ${b.dateLabel}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          '${b.totalSar.toStringAsFixed(0)} SAR',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: DuyaColors.emerald,
                          ),
                        ),
                      ],
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
