import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Makkah & Madinah Hotels search & booking screen sorted by Haram proximity.
class HotelsView extends StatefulWidget {
  const HotelsView({super.key});

  @override
  State<HotelsView> createState() => _HotelsViewState();
}

class _HotelsViewState extends State<HotelsView> {
  String _city = 'All';

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<JourneyRepository>();
    final hotels = _city == 'All'
        ? repo.hotels
        : repo.hotels.where((h) => h.city == _city).toList();

    return DuyaSubpageScaffold(
      title: 'Hotels',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          Wrap(
            spacing: 8,
            children: ['All', 'Makkah', 'Madinah']
                .map(
                  (c) => ChoiceChip(
                    label: Text(c),
                    selected: _city == c,
                    onSelected: (_) => setState(() => _city = c),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          ...hotels.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: DuyaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F3EE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.hotel,
                            color: DuyaColors.emerald,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                h.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              Text('${h.city} • ${h.distanceToHaram}'),
                            ],
                          ),
                        ),
                        Text(
                          '★ ${h.rating}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: DuyaColors.desertGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(h.description),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: h.amenities
                          .map((a) => Chip(label: Text(a, style: const TextStyle(fontSize: 10))))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '${h.pricePerNightSar.toStringAsFixed(0)} SAR / night',
                          style: const TextStyle(
                            color: DuyaColors.emerald,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            repo.addBooking(
                              type: 'Hotel',
                              title: h.name,
                              subtitle: '${h.city} • 2 Nights Stay',
                              dateLabel: 'Upcoming Check-in',
                              totalSar: h.pricePerNightSar * 2,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Hotel reservation confirmed!'),
                              ),
                            );
                            context.push('/journey/bookings');
                          },
                          child: const Text('Reserve Room'),
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
