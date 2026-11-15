import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../core/localization/app_strings.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Auth gate after onboarding — allows full guest exploration or signing in.
class WelcomeGateView extends StatelessWidget {
  const WelcomeGateView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final s = AppStrings(isArabic: auth.isArabic);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DuyaDaylightBackground(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/hero_mosque_header.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: Color(0xFFEAF2EF),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.55, 1.0],
                        colors: [
                          Color(0x30FFFFFF),
                          Color(0xA6F3F7F5),
                          Color(0xFFF3F7F5),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 78,
                              height: 82,
                              child: CustomPaint(
                                painter: DuyaArchLogoPainter(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Duya',
                              style: TextStyle(
                                color: Color(0xFF10553F),
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: DuyaColors.desertGoldSoft,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'بِسْمِ اللَّهِ نَبْدَأُ',
                                style: TextStyle(
                                  color: DuyaColors.emerald,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
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
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: DuyaCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Are you ready to begin your spiritual journey?',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sign in to sync Rawdah permits, travel bookings, and daily Challenge entries — or explore freely as a guest.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => context.push('/auth/login'),
                            child: Text(s.loginOrRegister),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              await auth.continueAsGuest();
                              if (context.mounted) context.go('/home');
                            },
                            child: Text(s.continueAsGuest),
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
    );
  }
}
