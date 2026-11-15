import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../core/localization/app_strings.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/theme/duya_typography.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// 5-slide editorial-Islamic onboarding flow maintaining all core concepts
/// in an original Haram Emerald, Celestial & Desert Gold layout.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < 4) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final s = AppStrings(isArabic: auth.isArabic);

    final slides = [
      _SlideData(
        badge: '01 • JOURNEY',
        title: auth.isArabic ? 'عمرتك في دقائق' : 'Umrah in Minutes',
        subtitle: auth.isArabic
            ? 'الرحلات والفنادق والتصاريح في مكان واحد.'
            : 'Flights, Haram-view stays, and permits — thoughtfully unified.',
        preview: const _OrbitNamesPreview(),
      ),
      _SlideData(
        badge: '02 • AL-RAWDAH',
        title: auth.isArabic ? 'ادخل الروضة الشريفة' : "Enter the Prophet's ﷺ Garden",
        subtitle: auth.isArabic
            ? 'احجز موعد صلاتك في الروضة بكل يسر.'
            : 'Reserve your tranquil moment of prayer in Al-Rawdah Al-Sharifah.',
        preview: const _RawdahArchPreview(),
      ),
      _SlideData(
        badge: '03 • QUR’AN & DUAS',
        title: auth.isArabic ? 'القرآن والأدعية معك دائماً' : 'Qur’an & Duas, Always With You',
        subtitle: auth.isArabic
            ? 'اقرأ واستمع وتدبّر في كل وقت ومكان.'
            : 'Read Uthmani script, explore Athkar, or listen anytime, anywhere.',
        preview: const _QuranPreviewCard(),
      ),
      _SlideData(
        badge: '04 • PRAYER & QIBLA',
        title: auth.isArabic ? 'حان وقت الصلاة' : "It's Time to Pray",
        subtitle: auth.isArabic
            ? 'مواقيت دقيقة وتنبيهات ذكية واتجاه القبلة.'
            : 'Astronomically accurate prayer times, smart reminders, and live Qibla.',
        preview: const _PrayerCardPreview(),
      ),
      _SlideData(
        badge: '05 • TRAVEL WALLET',
        title: auth.isArabic ? 'محفظة رحلتك بسهولة' : 'Manage Your Travel Wallet',
        subtitle: auth.isArabic
            ? 'تابع رصيدك ومصروفاتك بالريال والعملات الأخرى.'
            : 'Track pilgrimage funds, multi-currency rates, and bookings effortlessly.',
        preview: const _WalletPreviewCard(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DuyaDaylightBackground(
        child: SafeArea(
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () =>
                        auth.setLocale(auth.isArabic ? 'en' : 'ar'),
                    icon: const Icon(Icons.translate, size: 17),
                    label: Text(auth.isArabic ? 'English' : 'العربية'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/welcome'),
                    child: Text(s.skip),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: (constraints.maxHeight - 16).clamp(
                            0.0,
                            double.infinity,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 240,
                                  maxWidth: 340,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: SizedBox(
                                    width: 300,
                                    child: Center(child: slide.preview),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                    slide.badge,
                                    style: const TextStyle(
                                      color: DuyaColors.emerald,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  slide.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  slide.subtitle,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                children: [
                  Row(
                    children: List.generate(slides.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        margin: const EdgeInsets.only(right: 6),
                        height: 7,
                        width: active ? 26 : 8,
                        decoration: BoxDecoration(
                          color: active
                              ? DuyaColors.emerald
                              : DuyaColors.borderLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _next,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_currentPage == 4 ? s.getStarted : 'Next'),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
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
    );
  }
}

class _SlideData {
  const _SlideData({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.preview,
  });

  final String badge;
  final String title;
  final String subtitle;
  final Widget preview;
}

class _OrbitNamesPreview extends StatelessWidget {
  const _OrbitNamesPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 248,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: DuyaCard.lightShadow,
        border: Border.all(
          color: DuyaColors.emerald.withValues(alpha: 0.14),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(228, 228),
            painter: ConcentricOrbitPainter(
              color: DuyaColors.emerald.withValues(alpha: 0.22),
            ),
          ),
          const SizedBox(
            width: 78,
            height: 78,
            child: CustomPaint(painter: DuyaArchLogoPainter()),
          ),
          const Positioned(
            bottom: 24,
            child: Text(
              'Makkah • Madinah • Global Ummah',
              style: TextStyle(
                color: DuyaColors.emerald,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RawdahArchPreview extends StatelessWidget {
  const _RawdahArchPreview();

  @override
  Widget build(BuildContext context) {
    return DuyaDaylightBannerCard(
      imageAsset: 'assets/images/live_mosque_day.jpg',
      padding: const EdgeInsets.all(22),
      child: SizedBox(
        width: 240,
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F3EE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.mosque,
                color: DuyaColors.emerald,
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Al-Rawdah Al-Sharifah',
              style: TextStyle(
                color: Color(0xFF10553F),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Slot Verified • QR Ready',
              style: TextStyle(
                color: DuyaColors.textSecondaryLight,
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuranPreviewCard extends StatelessWidget {
  const _QuranPreviewCard();

  @override
  Widget build(BuildContext context) {
    return DuyaCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'مَا وَدَّعَكَ رَبُّكَ وَمَا قَلَىٰ',
            textAlign: TextAlign.center,
            style: DuyaTypography.arabicScript(
              fontSize: 20,
              color: DuyaColors.emerald,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your Lord has not abandoned you, nor has He become hateful.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5),
          ),
          const Divider(height: 24),
          Text(
            'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ',
            textAlign: TextAlign.center,
            style: DuyaTypography.arabicScript(
              fontSize: 20,
              color: DuyaColors.celestialNight,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'And surely your Lord will give so much to you that you will be pleased.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _PrayerCardPreview extends StatelessWidget {
  const _PrayerCardPreview();

  @override
  Widget build(BuildContext context) {
    return DuyaDaylightBannerCard(
      imageAsset: 'assets/images/hero_mosque_header.jpg',
      padding: const EdgeInsets.all(22),
      child: SizedBox(
        width: 240,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F3EE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.explore,
                color: DuyaColors.emerald,
                size: 32,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Dhuhr',
              style: TextStyle(
                color: DuyaColors.textSecondaryLight,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              '12 : 08',
              style: TextStyle(
                color: Color(0xFF10553F),
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Makkah • Pause & reset in prayer',
              style: TextStyle(
                color: DuyaColors.emerald,
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletPreviewCard extends StatelessWidget {
  const _WalletPreviewCard();

  @override
  Widget build(BuildContext context) {
    return const DuyaCard(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current Balance', style: TextStyle(fontSize: 10.5)),
          SizedBox(height: 4),
          Text(
            '22,060 SAR',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: DuyaColors.emerald,
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            dense: true,
            leading: Icon(Icons.hotel_outlined, color: DuyaColors.emerald),
            title: Text('Hotel Booking'),
            trailing: Text('-1,750 SAR'),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.add_card, color: DuyaColors.success),
            title: Text('International Top-Up'),
            trailing: Text('+2,100 SAR'),
          ),
        ],
      ),
    );
  }
}
