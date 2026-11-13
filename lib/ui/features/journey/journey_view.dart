import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/journey_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Journey tab: Flights, Hotels, Heritage Places, My Bookings,
/// Clock Tower Museum experience, and AI Trip Builder CTA.
class JourneyView extends StatefulWidget {
  const JourneyView({super.key});

  @override
  State<JourneyView> createState() => _JourneyViewState();
}

class _JourneyViewState extends State<JourneyView> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<JourneyRepository>();

    final featuredRestaurants = repo.places.where((p) {
      if (_search.trim().isEmpty) return true;
      return p.name.toLowerCase().contains(_search.toLowerCase()) ||
          p.category.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    final clockTower = repo.getAttractionById('clock_tower_museum');

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              gradient: DuyaColors.celestialHeroGradient,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const DuyaLogoBadge(
                          size: 30,
                          color: DuyaColors.desertGold,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isArabic ? 'رحلة العمرة والزيارة' : 'Your Journey',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => context.push('/profile'),
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _JourneyTile(
                          icon: Icons.flight_takeoff,
                          label: isArabic ? 'رحلات الطيران' : 'Flights',
                          onTap: () => context.push('/journey/flights'),
                        ),
                        _JourneyTile(
                          icon: Icons.hotel_outlined,
                          label: isArabic ? 'الفنادق' : 'Hotels',
                          onTap: () => context.push('/journey/hotels'),
                        ),
                        _JourneyTile(
                          icon: Icons.place_outlined,
                          label: isArabic ? 'الأماكن' : 'Places',
                          onTap: () => context.push('/journey/places'),
                        ),
                        _JourneyTile(
                          icon: Icons.confirmation_num_outlined,
                          label: isArabic ? 'حجوزاتي' : 'Bookings',
                          onTap: () => context.push('/journey/bookings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Unified Search
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
          sliver: SliverToBoxAdapter(
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search restaurants, Ziyarat, Makkah & Madinah...',
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
        ),
        // Featured Restaurants & Heritage Dining
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
            child: DuyaSectionHeader(
              title: 'Featured Restaurants & Places',
              onActionTap: () => context.push('/journey/places'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 146,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: featuredRestaurants.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final place = featuredRestaurants[index];
                return SizedBox(
                  width: 245,
                  child: DuyaCard(
                    onTap: () => context.push('/journey/places'),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 86,
                          decoration: BoxDecoration(
                            color: Color(place.accentHex),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                place.category,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: DuyaColors.emerald,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                place.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${place.city} • ★ ${place.rating}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Clock Tower Museum Experience Card
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
          sliver: SliverToBoxAdapter(
            child: DuyaCard(
              onTap: () =>
                  context.push('/journey/attraction/${clockTower.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: DuyaColors.desertGoldSoft,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Bookings • Makkah Highlight',
                      style: TextStyle(
                        color: DuyaColors.emerald,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Explore ${clockTower.title}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Color(clockTower.accentHex),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    clockTower.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.push('/journey/attraction/${clockTower.id}'),
                      child: const Text('View Tickets'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // AI Trip Planner CTA
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF9ECEF), Color(0xFFFBF3E4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: DuyaColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: DuyaColors.desertGold),
                      SizedBox(width: 8),
                      Text(
                        'Try Duya AI Planner',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: DuyaColors.emerald,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Build a trip plan for me that includes the best spiritual & heritage experiences in Makkah and Madinah',
                    style: TextStyle(
                      color: DuyaColors.textPrimaryLight,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/journey/trip-builder'),
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    label: const Text('Build Your Trip Now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _JourneyTile extends StatelessWidget {
  const _JourneyTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
