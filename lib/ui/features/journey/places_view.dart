import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Heritage Restaurants (Abu Zaid, Abu Osaid, Khayal) & Sacred Ziyarat Places.
class PlacesView extends StatefulWidget {
  const PlacesView({super.key});

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final repo = context.read<JourneyRepository>();
    final items = _category == 'All'
        ? repo.places
        : repo.places.where((p) => p.category == _category).toList();

    return DuyaSubpageScaffold(
      title: 'Places',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          Wrap(
            spacing: 8,
            children: [
              'All',
              'Heritage Restaurants',
              'Restaurants',
              'Ziyarat',
            ]
                .map(
                  (c) => ChoiceChip(
                    label: Text(c),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DuyaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F3EE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            p.category == 'Ziyarat'
                                ? Icons.mosque
                                : Icons.restaurant,
                            color: DuyaColors.emerald,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              Text('${p.city} • ${p.distanceLabel}'),
                            ],
                          ),
                        ),
                        Text(
                          '★ ${p.rating}',
                          style: const TextStyle(
                            color: DuyaColors.desertGold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(p.description),
                    const SizedBox(height: 8),
                    Chip(
                      backgroundColor: DuyaColors.desertGoldSoft,
                      label: Text(
                        p.signatureNote,
                        style: const TextStyle(
                          color: DuyaColors.emerald,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.5,
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
