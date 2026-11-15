import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../../domain/models/journey_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// AI Trip Planner Wizard generating day-by-day Makkah & Madinah itineraries.
class TripBuilderView extends StatefulWidget {
  const TripBuilderView({super.key});

  @override
  State<TripBuilderView> createState() => _TripBuilderViewState();
}

class _TripBuilderViewState extends State<TripBuilderView> {
  int _days = 5;
  String _pace = 'Balanced';
  bool _includeClockTower = true;
  List<TripItineraryDay>? _generated;

  void _generate() {
    final repo = context.read<JourneyRepository>();
    setState(() {
      _generated = repo.buildItinerary(
        totalDays: _days,
        pace: _pace,
        includeClockTower: _includeClockTower,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _generate());
  }

  @override
  Widget build(BuildContext context) {
    return DuyaSubpageScaffold(
      title: 'AI Trip Planner',
      subtitle: 'Custom Makkah & Madinah itinerary',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trip Preferences',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Text('Duration: $_days Days (Makkah & Madinah)'),
                Slider(
                  value: _days.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  label: '$_days days',
                  onChanged: (v) {
                    setState(() => _days = v.round());
                    _generate();
                  },
                ),
                Wrap(
                  spacing: 8,
                  children: ['Relaxed', 'Balanced', 'Active']
                      .map(
                        (p) => ChoiceChip(
                          label: Text(p),
                          selected: _pace == p,
                          onSelected: (_) {
                            setState(() => _pace = p);
                            _generate();
                          },
                        ),
                      )
                      .toList(),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Include Clock Tower Museum'),
                  value: _includeClockTower,
                  onChanged: (v) {
                    setState(() => _includeClockTower = v);
                    _generate();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Your Custom Itinerary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (_generated != null)
            ..._generated!.map(
              (day) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DuyaCard(
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
                              color: DuyaColors.desertGoldSoft,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Day ${day.dayNumber} • ${day.city}',
                              style: const TextStyle(
                                color: DuyaColors.emerald,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        day.focusTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...day.activities.map(
                        (act) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(child: Text(act)),
                            ],
                          ),
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
