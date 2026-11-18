import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Complete searchable directory of every Duya worship, permit, travel & store tool.
class AllServicesView extends StatefulWidget {
  const AllServicesView({super.key});

  @override
  State<AllServicesView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<AllServicesView> {
  String _query = '';

  static const _services = [
    (
      title: 'Rawdah & Umrah Permits',
      subtitle: 'Book entry slots & QR passes',
      icon: Icons.mosque_outlined,
      route: '/permits',
      category: 'Permits & Haram',
    ),
    (
      title: 'Motawef Ritual Tracker',
      subtitle: '7-lap Tawaf & Sa‘i counter + Duas',
      icon: Icons.loop_rounded,
      route: '/motawef',
      category: 'Worship & Spiritual',
    ),
    (
      title: 'Haram Golf Cart & Zamzam',
      subtitle: 'Mobility assistance & water stations',
      icon: Icons.electric_rickshaw_outlined,
      route: '/haram-services',
      category: 'Permits & Haram',
    ),
    (
      title: 'Prayer Times & Adhan',
      subtitle: 'Calculation methods & reminders',
      icon: Icons.access_time,
      route: '/prayer-times',
      category: 'Worship & Spiritual',
    ),
    (
      title: 'Qibla Compass',
      subtitle: 'Kaaba bearing & distance',
      icon: Icons.explore_outlined,
      route: '/qibla',
      category: 'Worship & Spiritual',
    ),
    (
      title: 'Holy Qur’an & Reciters',
      subtitle: 'Read, bookmark & listen to 114 surahs',
      icon: Icons.menu_book_rounded,
      route: '/content/quran',
      category: 'Worship & Spiritual',
    ),
    (
      title: 'Duas & Athkar',
      subtitle: 'Supplications + Tasbih counter',
      icon: Icons.volunteer_activism_outlined,
      route: '/content/duas',
      category: 'Worship & Spiritual',
    ),
    (
      title: 'Daily Knowledge Challenge',
      subtitle: 'Spend Ilm to open 8 doors & earn rewards',
      icon: Icons.auto_awesome_outlined,
      route: '/challenge/intro',
      category: 'Community & Learning',
    ),
    (
      title: 'AI Trip Planner',
      subtitle: 'Custom Makkah & Madinah itinerary',
      icon: Icons.auto_awesome,
      route: '/journey/trip-builder',
      category: 'Travel & Market',
    ),
    (
      title: 'Flights, Hotels & Dining',
      subtitle: 'Manage bookings & heritage places',
      icon: Icons.flight_takeoff,
      route: '/journey',
      category: 'Travel & Market',
    ),
    (
      title: 'Duya Market',
      subtitle: 'Zamzam delivery, Ihram & gifts',
      icon: Icons.storefront_outlined,
      route: '/market',
      category: 'Travel & Market',
    ),
    (
      title: 'Travel Wallet',
      subtitle: 'Multi-currency balance & ledger',
      icon: Icons.account_balance_wallet_outlined,
      route: '/wallet',
      category: 'Travel & Market',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _services.where((s) {
      final q = _query.toLowerCase();
      return s.title.toLowerCase().contains(q) ||
          s.subtitle.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q);
    }).toList();

    return DuyaSubpageScaffold(
      title: 'Services',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: DuyaColors.emerald),
              hintText: 'Search permits, worship, travel...',
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                onTap: () => context.push(s.route),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F3EE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(s.icon, color: DuyaColors.emerald),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                            ),
                          ),
                          Text(
                            '${s.category} • ${s.subtitle}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
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
