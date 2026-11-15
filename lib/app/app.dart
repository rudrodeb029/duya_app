import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/ai_repository.dart';
import '../data/repositories/auth_profile_repository.dart';
import '../data/repositories/challenge_repository.dart';
import '../data/repositories/content_repository.dart';
import '../data/repositories/journey_repository.dart';
import '../data/repositories/market_wallet_repository.dart';
import '../data/repositories/prayer_ritual_repository.dart';
import '../data/services/prayer_calculation_service.dart';
import '../data/services/preferences_service.dart';
import '../ui/core/theme/duya_theme.dart';
import 'router.dart';

/// Root Duya application widget wiring dependency injection, theme, localization, and routing.
class DuyaApp extends StatefulWidget {
  const DuyaApp({
    super.key,
    required this.authRepository,
    this.challengeRepository,
    this.initialLocation = '/splash',
  });

  final AuthProfileRepository authRepository;
  final ChallengeRepository? challengeRepository;
  final String initialLocation;

  static Future<DuyaApp> bootstrap({String initialLocation = '/splash'}) async {
    final prefs = PreferencesService();
    await prefs.init();
    final authRepo = AuthProfileRepository(prefs: prefs);
    await authRepo.load();
    final challengeRepo = ChallengeRepository();
    await challengeRepo.loadExpandedQuestions();
    return DuyaApp(
      authRepository: authRepo,
      challengeRepository: challengeRepo,
      initialLocation: initialLocation,
    );
  }

  @override
  State<DuyaApp> createState() => _DuyaAppState();
}

class _DuyaAppState extends State<DuyaApp> {
  late final GoRouter _router =
      createDuyaRouter(initialLocation: widget.initialLocation);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProfileRepository>.value(
          value: widget.authRepository,
        ),
        ChangeNotifierProvider<PrayerRitualRepository>(
          create: (_) => PrayerRitualRepository(
            calcService: PrayerCalculationService(),
          ),
        ),
        Provider<ContentRepository>(
          create: (_) => ContentRepository(),
        ),
        ChangeNotifierProvider<JourneyRepository>(
          create: (_) => JourneyRepository(),
        ),
        ChangeNotifierProvider<MarketWalletRepository>(
          create: (_) => MarketWalletRepository(),
        ),
        if (widget.challengeRepository != null)
          ChangeNotifierProvider<ChallengeRepository>.value(
            value: widget.challengeRepository!,
          )
        else
          ChangeNotifierProvider<ChallengeRepository>(
            create: (_) => ChallengeRepository()..loadExpandedQuestions(),
          ),
        ChangeNotifierProvider<AiRepository>(
          create: (_) => AiRepository(),
        ),
      ],
      child: Consumer<AuthProfileRepository>(
        builder: (context, auth, _) {
          return MaterialApp.router(
            title: 'Duya',
            debugShowCheckedModeBanner: false,
            theme: DuyaTheme.light(),
            darkTheme: DuyaTheme.dark(),
            themeMode: auth.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            locale: Locale(auth.localeCode),
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
