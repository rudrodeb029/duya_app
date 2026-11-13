import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Flights Search & Reservation page for JED & MED gateways.
class FlightsView extends StatefulWidget {
  const FlightsView({super.key});

  @override
  State<FlightsView> createState() => _FlightsViewState();
}

class _FlightsViewState extends State<FlightsView> {
  String _cabinFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<JourneyRepository>();
    final flights = _cabinFilter == 'All'
        ? repo.flights
        : repo.flights.where((f) => f.cabinClass == _cabinFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Flights to Makkah & Madinah')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: ['All', 'Economy', 'Business']
                .map(
                  (c) => ChoiceChip(
                    label: Text(c),
                    selected: _cabinFilter == c,
                    onSelected: (_) => setState(() => _cabinFilter = c),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          ...flights.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DuyaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${f.airline} • ${f.flightCode}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Chip(label: Text(f.cabinClass)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${f.fromCode} ${f.departureTime}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(),
                          ),
                        ),
                        Text(
                          '${f.toCode} ${f.arrivalTime}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('${f.duration} • ${f.stopsLabel}'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '${f.priceSar.toStringAsFixed(0)} SAR',
                          style: const TextStyle(
                            color: DuyaColors.emerald,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            repo.addBooking(
                              type: 'Flight',
                              title: '${f.airline} (${f.fromCode} → ${f.toCode})',
                              subtitle: '${f.flightCode} • ${f.cabinClass}',
                              dateLabel: f.departureTime,
                              totalSar: f.priceSar,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Flight added to My Bookings!'),
                              ),
                            );
                            context.push('/journey/bookings');
                          },
                          child: const Text('Book Flight'),
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
