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
              title: isArabic ? 'رحلة العمرة والزيارة' : 'Journey',
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
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            sliver: SliverToBoxAdapter(
              child: TextField(
                style: const TextStyle(fontSize: 11.5),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: DuyaColors.emerald,
                    size: 18,
                  ),
                  hintText: 'Search restaurants, Ziyarat, Makkah & Madinah...',
                  hintStyle: TextStyle(fontSize: 11.0),
                ),
                onChanged: (v) => setState(() => _search = v),
              ),
            ),
          ),
          // Featured Restaurants & Heritage Dining
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: DuyaSectionHeader(
                title: 'Featured Restaurants & Places',
                onActionTap: () => context.push('/journey/places'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 98,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: featuredRestaurants.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final place = featuredRestaurants[index];
                  return SizedBox(
                    width: 224,
                    child: DuyaCard(
                      padding: const EdgeInsets.all(10),
                      onTap: () => context.push('/journey/places'),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7F3EE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.restaurant_menu,
                              color: DuyaColors.emerald,
                              size: 21,
                            ),
                          ),
                          const SizedBox(width: 10),
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
                                    fontSize: 9.0,
                                    color: DuyaColors.emerald,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  place.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${place.city} • ★ ${place.rating}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 10.0),
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
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            sliver: SliverToBoxAdapter(
              child: DuyaDaylightBannerCard(
                imageAsset: 'assets/images/promo_madinah_hotel.jpg',
                onTap: () =>
                    context.push('/journey/attraction/${clockTower.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 215),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore ${clockTower.title}',
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF10553F),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            clockTower.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 10.0, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 34),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () =>
                          context.push('/journey/attraction/${clockTower.id}'),
                      child: const Text(
                        'View Tickets',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // AI Trip Planner CTA
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 24),
            sliver: SliverToBoxAdapter(
              child: DuyaCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F3EE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: DuyaColors.emerald,
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Try Duya AI Planner',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                            color: DuyaColors.emerald,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Build a trip plan for me that includes the best spiritual & heritage experiences in Makkah and Madinah',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () => context.push('/journey/trip-builder'),
                      icon: const Icon(Icons.arrow_forward, size: 15),
                      label: const Text(
                        'Build Your Trip Now',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
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
