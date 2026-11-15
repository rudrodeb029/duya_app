import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../core/localization/app_strings.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Home Dashboard: Sunlit daylight header with Mosque & lanterns, 4 elevated
/// action tiles, ribboned Prayer banner, 5-item services bar, Kaaba Challenge
/// banner, and Live Friday Sermon showcase.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const _cardShadow = [
    BoxShadow(
      color: Color(0x130E523C),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final prayerRepo = context.watch<PrayerRitualRepository>();
    final contentRepo = context.read<ContentRepository>();
    final s = AppStrings(isArabic: auth.isArabic);

    final schedule = prayerRepo.getSchedule();
    final next = schedule.nextPrayer;
    final formattedTime = DateFormat.jm().format(next.time);
    final liveMakkah = contentRepo.liveChannels.first;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFEEF4F2), Color(0xFFF3F7F5), Color(0xFFF6F9F8)],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // Top Daylight Hero Header + Overlapping 4-Tile Quick Bar
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/hero_mosque_header.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                        errorBuilder: (_, _, _) => Container(
                          color: const Color(0xFFEAF2EF),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.48, 0.84, 1.0],
                            colors: [
                              Color(0x08FFFFFF),
                              Color(0x28F3F7F5),
                              Color(0xD8F3F7F5),
                              Color(0xFFF3F7F5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 52,
                              height: 54,
                              child: CustomPaint(
                                painter: DuyaArchLogoPainter(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              s.appName,
                              style: const TextStyle(
                                color: Color(0xFF10553F),
                                fontSize: 23,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const Spacer(),
                            DuyaCircleActionButton(
                              icon: Icons.notifications_none_rounded,
                              tooltip: 'Notifications',
                              size: 42,
                              onTap: () => _showNotificationsSheet(context),
                            ),
                            const SizedBox(width: 10),
                            Material(
                              color: Colors.white.withValues(alpha: 0.94),
                              shape: const CircleBorder(),
                              elevation: 3,
                              shadowColor: const Color(0x220E523C),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () => context.push('/profile'),
                                child: const SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xFF136048),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 76),
                        // 4 Primary Elevated Quick-Action Tiles
                        Row(
                          children: [
                            Expanded(
                              child: _QuickServiceTile(
                                label: s.rawdah,
                                onTap: () => context.push('/permits?type=rawdah'),
                                iconWidget: const SizedBox(
                                  width: 34,
                                  height: 30,
                                  child: CustomPaint(
                                    painter: RawdahMosqueIconPainter(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _QuickServiceTile(
                                label: s.hajj,
                                onTap: () => context.push('/content/articles'),
                                iconWidget: const SizedBox(
                                  width: 32,
                                  height: 30,
                                  child: CustomPaint(
                                    painter:
                                        IsometricKaabaIconPainter(variant: 0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _QuickServiceTile(
                                label: s.umrah,
                                onTap: () => context.push('/motawef'),
                                iconWidget: const SizedBox(
                                  width: 32,
                                  height: 30,
                                  child: CustomPaint(
                                    painter:
                                        IsometricKaabaIconPainter(variant: 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _QuickServiceTile(
                                label: s.allServices,
                                onTap: () => context.push('/services'),
                                iconWidget: const Icon(
                                  Icons.grid_view_rounded,
                                  color: Color(0xFFC2902E),
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Ribboned Prayer Banner Card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _cardShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 78,
                        bottom: 0,
                        width: 120,
                        height: 66,
                        child: IgnorePointer(
                          child: CustomPaint(painter: MosqueWatermarkPainter()),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => context.push('/qibla'),
                            child: SizedBox(
                              width: 88,
                              height: 88,
                              child: Stack(
                                children: [
                                  const Positioned.fill(
                                    child: CustomPaint(
                                      painter: PrayerArchRibbonPainter(),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Container(
                                        width: 42,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF17664E),
                                          border: Border.all(
                                            color: const Color(0xFFE7CA73),
                                            width: 1.8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.explore_outlined,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 48,
                            color: const Color(0xFFE1EAE5),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: InkWell(
                              onTap: () => context.push('/prayer-times'),
                              child: Center(
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    '${next.localizedTitle(auth.isArabic)} $formattedTime',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF1B3A30),
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: Color(0xFF186A50),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        child: Text(
                                          '${schedule.location.localizedCity(auth.isArabic)} • Qibla ${schedule.qiblaBearingDegrees.toStringAsFixed(0)}°',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF4F6960),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                if (!auth.profile.locationEnabled) {
                                  showLocationPermissionSheet(
                                    context,
                                    onEnableLocation: () =>
                                        auth.setLocationEnabled(true),
                                  );
                                } else {
                                  context.push('/prayer-times');
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE7F2EC),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Color(0xFF14634C),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Color(0xFF14634C),
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 14,
                                      color: Color(0xFF14634C),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 5-Slot Quick Worship Strip Bar
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _cardShadow,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      _StripActionItem(
                        icon: Icons.autorenew_rounded,
                        label: s.motawef,
                        onTap: () => context.push('/motawef'),
                      ),
                      const _VerticalHairline(),
                      _StripActionItem(
                        icon: Icons.menu_book_rounded,
                        label: s.quran,
                        onTap: () => context.push('/content/quran'),
                      ),
                      const _VerticalHairline(),
                      _StripActionItem(
                        icon: Icons.volunteer_activism_rounded,
                        label: s.duas,
                        onTap: () => context.push('/content/duas'),
                      ),
                      const _VerticalHairline(),
                      _StripActionItem(
                        icon: Icons.explore_outlined,
                        label: s.qibla,
                        onTap: () => context.push('/qibla'),
                      ),
                      const _VerticalHairline(),
                      _StripActionItem(
                        icon: Icons.local_shipping_outlined,
                        label: s.mobility,
                        onTap: () => context.push('/haram-services'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Daily Knowledge Challenge Card (Daylight Kaaba Illustration)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _cardShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/challenge_kaaba_day.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.centerRight,
                          errorBuilder: (_, _, _) => Container(
                            color: const Color(0xFFF6F9F7),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [0.0, 0.44, 0.68, 1.0],
                              colors: [
                                Colors.white,
                                Colors.white.withValues(alpha: 0.96),
                                Colors.white.withValues(alpha: 0.16),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        width: 190,
                        height: 62,
                        child: IgnorePointer(
                          child: CustomPaint(painter: CardSilkRibbonPainter()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 150, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '100 Umrah Trips & 10,000\nZamzam Cartons',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF1A382E),
                                fontSize: 15.5,
                                height: 1.2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Open a knowledge door daily, answer correctly, and enter the draw for you and a loved one.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF536A61),
                                fontSize: 10.5,
                                height: 1.35,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF115841),
                                    Color(0xFF1E7558),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF14634C)
                                        .withValues(alpha: 0.28),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () =>
                                      context.push('/challenge/intro'),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Start the Challenge',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Live Friday Sermon Card (Daylight Grand Mosque Illustration)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            sliver: SliverToBoxAdapter(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => context.push('/content/live/${liveMakkah.id}'),
                child: Container(
                  height: 174,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _cardShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/live_mosque_day.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment.centerRight,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFFF6F9F7),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: const [0.0, 0.42, 0.65, 1.0],
                                colors: [
                                  Colors.white,
                                  Colors.white.withValues(alpha: 0.95),
                                  Colors.white.withValues(alpha: 0.14),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 0,
                          bottom: 0,
                          width: 190,
                          height: 60,
                          child: IgnorePointer(
                            child: CustomPaint(painter: CardSilkRibbonPainter()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 16, 150, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD92D20),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 7,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'LIVE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'The Friday Sermon',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF1A382E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                liveMakkah.reciterOrImam,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF536A61),
                                  fontSize: 11,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF14634C)
                                          .withValues(alpha: 0.14),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: Color(0xFF14634C),
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Watch Live',
                                      style: TextStyle(
                                        color: Color(0xFF1A382E),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Curated Highlights Carousel (below the fold)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 176,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 22),
                children: [
                  _PromoHighlightCard(
                    tag: 'Zamzam Water',
                    title: 'Delivered safely to your hotel or airport',
                    imageAsset: 'assets/images/promo_zamzam.jpg',
                    scrimTint: const Color(0xFF1B6953),
                    icon: Icons.water_drop_outlined,
                    onTap: () => context.push('/market/category/zamzam'),
                  ),
                  const SizedBox(width: 12),
                  _PromoHighlightCard(
                    tag: 'Madinah Hotels',
                    title: 'Book stays steps from Al-Rawdah',
                    imageAsset: 'assets/images/promo_madinah_hotel.jpg',
                    scrimTint: const Color(0xFF145E48),
                    icon: Icons.hotel_outlined,
                    onTap: () => context.push('/journey/hotels'),
                  ),
                  const SizedBox(width: 12),
                  _PromoHighlightCard(
                    tag: 'Flights',
                    title: 'Seamless JED & MED flight options',
                    imageAsset: 'assets/images/promo_flights.jpg',
                    scrimTint: const Color(0xFF7D5D28),
                    icon: Icons.flight_takeoff,
                    onTap: () => context.push('/journey/flights'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickServiceTile extends StatelessWidget {
  const _QuickServiceTile({
    required this.iconWidget,
    required this.label,
    required this.onTap,
  });

  final Widget iconWidget;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconWidget,
                const SizedBox(height: 6),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1F3C32),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StripActionItem extends StatelessWidget {
  const _StripActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF14634C), size: 19),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF28433A),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalHairline extends StatelessWidget {
  const _VerticalHairline();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: const Color(0xFFE7EFEA),
    );
  }
}

class _PromoHighlightCard extends StatelessWidget {
  const _PromoHighlightCard({
    required this.tag,
    required this.title,
    required this.imageAsset,
    required this.scrimTint,
    required this.icon,
    required this.onTap,
  });

  final String tag;
  final String title;
  final String imageAsset;
  final Color scrimTint;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: HomeView._cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: scrimTint,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(color: scrimTint),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.44, 1.0],
                      colors: [
                        scrimTint.withValues(alpha: 0.72),
                        scrimTint.withValues(alpha: 0.08),
                        scrimTint.withValues(alpha: 0.88),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Icon(icon, color: Colors.white, size: 17),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showNotificationsSheet(BuildContext context) {
  const items = [
    (
      icon: Icons.access_time_rounded,
      title: 'Dhuhr Prayer Reminder',
      subtitle: 'Adhan alert enabled for Makkah schedule',
      route: '/prayer-times',
    ),
    (
      icon: Icons.mosque_outlined,
      title: 'Al-Rawdah Windows Open',
      subtitle: 'New entry slots available this week',
      route: '/permits?type=rawdah',
    ),
    (
      icon: Icons.campaign_outlined,
      title: 'Friday Sermon Live Now',
      subtitle: 'Watch Al-Masjid Al-Haram broadcast',
      route: '/content/live/live_makkah',
    ),
  ];

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notifications',
            style: Theme.of(ctx).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ...items.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                padding: const EdgeInsets.all(12),
                onTap: () {
                  Navigator.of(ctx).pop();
                  context.push(n.route);
                },
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F3EE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        n.icon,
                        color: const Color(0xFF14634C),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            n.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            n.subtitle,
                            style: Theme.of(ctx).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
