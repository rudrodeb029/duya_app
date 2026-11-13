import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../core/localization/app_strings.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Auth gate after onboarding — allows full guest exploration or signing in.
class WelcomeGateView extends StatelessWidget {
  const WelcomeGateView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final s = AppStrings(isArabic: auth.isArabic);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: DuyaColors.celestialHeroGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(36),
                ),
              ),
              child: const SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DuyaLogoBadge(size: 64, color: DuyaColors.desertGold),
                        SizedBox(height: 12),
                        Text(
                          'Duya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'بِسْمِ اللَّهِ نَبْدَأُ',
                          style: TextStyle(
                            color: DuyaColors.desertGoldSoft,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
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
        ],
      ),
    );
  }
}
