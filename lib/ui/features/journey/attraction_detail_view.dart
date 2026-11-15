import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/journey_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Attraction Detail & Ticket Booking page (e.g., Clock Tower Museum).
class AttractionDetailView extends StatefulWidget {
  const AttractionDetailView({super.key, required this.attractionId});

  final String attractionId;

  @override
  State<AttractionDetailView> createState() => _AttractionDetailViewState();
}

class _AttractionDetailViewState extends State<AttractionDetailView> {
  int _slotIndex = 0;
  int _guests = 2;

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<JourneyRepository>();
    final item = repo.getAttractionById(widget.attractionId);
    final slot = item.availableSlots[_slotIndex];

    return DuyaSubpageScaffold(
      title: item.title,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaDaylightBannerCard(
            imageAsset: 'assets/images/promo_madinah_hotel.jpg',
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text(
                    item.city.toUpperCase(),
                    style: const TextStyle(
                      color: DuyaColors.emerald,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 215),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xFF10553F),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(item.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 18),
          Text(
            'Highlights',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...item.highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: DuyaCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.star_outline, color: DuyaColors.desertGold),
                    const SizedBox(width: 10),
                    Expanded(child: Text(h)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Choose Time Slot',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(item.availableSlots.length, (i) {
              return ChoiceChip(
                label: Text(item.availableSlots[i]),
                selected: _slotIndex == i,
                onSelected: (_) => setState(() => _slotIndex = i),
              );
            }),
          ),
          const SizedBox(height: 16),
          DuyaCard(
            child: Row(
              children: [
                const Text(
                  'Visitors',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '$_guests',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _guests++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final total = item.ticketPriceSar * _guests;
              repo.addBooking(
                type: 'Attraction',
                title: item.title,
                subtitle: '$_guests Visitors • $slot',
                dateLabel: 'Tomorrow • $slot',
                totalSar: total,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tickets booked successfully!')),
              );
              context.push('/journey/bookings');
            },
            child: Text(
              'Book $_guests Tickets (${(item.ticketPriceSar * _guests).toStringAsFixed(0)} SAR)',
            ),
          ),
        ],
      ),
    );
  }
}
