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

    return DuyaDaylightBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DuyaDaylightHeader(
              title: isArabic ? 'رحلة العمرة والزيارة' : 'Your Journey',
              showBack: false,
              showLogo: true,
              actions: [
                DuyaCircleActionButton(
                  icon: Icons.person,
                  tooltip: 'Profile',
                  onTap: () => context.push('/profile'),
                ),
              ],
              bottom: Row(
                children: [
                  DuyaHeaderQuickTile(
                    icon: Icons.flight_takeoff,
                    label: isArabic ? 'رحلات الطيران' : 'Flights',
                    onTap: () => context.push('/journey/flights'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.hotel_outlined,
                    label: isArabic ? 'الفنادق' : 'Hotels',
                    onTap: () => context.push('/journey/hotels'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.place_outlined,
                    label: isArabic ? 'الأماكن' : 'Places',
                    onTap: () => context.push('/journey/places'),
                  ),
                  DuyaHeaderQuickTile(
                    icon: Icons.confirmation_num_outlined,
                    label: isArabic ? 'حجوزاتي' : 'Bookings',
                    onTap: () => context.push('/journey/bookings'),
                  ),
                ],
              ),
            ),
          ),
          // Unified Search
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            sliver: SliverToBoxAdapter(
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: DuyaColors.emerald),
                  hintText: 'Search restaurants, Ziyarat, Makkah & Madinah...',
                ),
                onChanged: (v) => setState(() => _search = v),
              ),
            ),
          ),
          // Featured Restaurants & Heritage Dining
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: DuyaSectionHeader(
                title: 'Featured Restaurants & Places',
                onActionTap: () => context.push('/journey/places'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 124,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: featuredRestaurants.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final place = featuredRestaurants[index];
                  return SizedBox(
                    width: 248,
                    child: DuyaCard(
                      padding: const EdgeInsets.all(14),
                      onTap: () => context.push('/journey/places'),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 68,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7F3EE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.restaurant_menu,
                              color: DuyaColors.emerald,
                              size: 26,
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
                                    fontSize: 10,
                                    color: DuyaColors.emerald,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  place.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
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
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
            sliver: SliverToBoxAdapter(
              child: DuyaDaylightBannerCard(
                imageAsset: 'assets/images/promo_madinah_hotel.jpg',
                onTap: () =>
                    context.push('/journey/attraction/${clockTower.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore ${clockTower.title}',
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF10553F),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            clockTower.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () =>
                          context.push('/journey/attraction/${clockTower.id}'),
                      child: const Text('View Tickets'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // AI Trip Planner CTA
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 28),
            sliver: SliverToBoxAdapter(
              child: DuyaCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F3EE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: DuyaColors.emerald,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Try Duya AI Planner',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: DuyaColors.emerald,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Build a trip plan for me that includes the best spiritual & heritage experiences in Makkah and Madinah',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium?.color,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 14),
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
      ),
    );
  }
}
