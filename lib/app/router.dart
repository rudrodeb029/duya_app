import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/core/widgets/duya_shell.dart';
import '../ui/features/ai_companion/duya_ai_view.dart';
import '../ui/features/challenge/challenge_help_view.dart';
import '../ui/features/challenge/challenge_intro_view.dart';
import '../ui/features/challenge/challenge_ilm_view.dart';
import '../ui/features/challenge/challenge_play_view.dart';
import '../ui/features/challenge/challenge_quiz_view.dart';
import '../ui/features/challenge/challenge_winners_view.dart';
import '../ui/features/content/articles_view.dart';
import '../ui/features/content/content_hub_view.dart';
import '../ui/features/content/dua_detail_view.dart';
import '../ui/features/content/duas_hub_view.dart';
import '../ui/features/content/live_player_view.dart';
import '../ui/features/content/quran_index_view.dart';
import '../ui/features/content/quran_reader_view.dart';
import '../ui/features/home/all_services_view.dart';
import '../ui/features/home/haram_services_view.dart';
import '../ui/features/home/home_view.dart';
import '../ui/features/home/motawef_view.dart';
import '../ui/features/home/permits_view.dart';
import '../ui/features/home/prayer_times_view.dart';
import '../ui/features/home/qibla_compass_view.dart';
import '../ui/features/journey/attraction_detail_view.dart';
import '../ui/features/journey/bookings_view.dart';
import '../ui/features/journey/flights_view.dart';
import '../ui/features/journey/hotels_view.dart';
import '../ui/features/journey/journey_view.dart';
import '../ui/features/journey/places_view.dart';
import '../ui/features/journey/trip_builder_view.dart';
import '../ui/features/market/cart_checkout_view.dart';
import '../ui/features/market/market_category_view.dart';
import '../ui/features/market/market_home_view.dart';
import '../ui/features/market/product_detail_view.dart';
import '../ui/features/onboarding/login_view.dart';
import '../ui/features/onboarding/onboarding_view.dart';
import '../ui/features/onboarding/register_view.dart';
import '../ui/features/onboarding/splash_view.dart';
import '../ui/features/onboarding/welcome_gate_view.dart';
import '../ui/features/profile_wallet/profile_view.dart';
import '../ui/features/profile_wallet/wallet_view.dart';

/// Builds the declarative [GoRouter] route tree for Duya.
GoRouter createDuyaRouter({String initialLocation = '/splash'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeGateView(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => LoginView(
          autoTriggerSso: state.uri.queryParameters['sso'] == '1',
        ),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterView(),
      ),

      // Persistent 4-tab App Shell (+ Duya AI Pill)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DuyaShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/journey',
                builder: (context, state) => const JourneyView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/content',
                builder: (context, state) => const ContentHubView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/market',
                builder: (context, state) => const MarketHomeView(),
              ),
            ],
          ),
        ],
      ),

      // Home & Worship Tools
      GoRoute(
        path: '/services',
        builder: (context, state) => const AllServicesView(),
      ),
      GoRoute(
        path: '/prayer-times',
        builder: (context, state) => const PrayerTimesView(),
      ),
      GoRoute(
        path: '/qibla',
        builder: (context, state) => const QiblaCompassView(),
      ),
      GoRoute(
        path: '/motawef',
        builder: (context, state) => const MotawefView(),
      ),
      GoRoute(
        path: '/permits',
        builder: (context, state) => PermitsView(
          initialFilter: state.uri.queryParameters['type'] ?? 'all',
        ),
      ),
      GoRoute(
        path: '/haram-services',
        builder: (context, state) => const HaramServicesView(),
      ),

      // Journey Sub-pages
      GoRoute(
        path: '/journey/flights',
        builder: (context, state) => const FlightsView(),
      ),
      GoRoute(
        path: '/journey/hotels',
        builder: (context, state) => const HotelsView(),
      ),
      GoRoute(
        path: '/journey/places',
        builder: (context, state) => const PlacesView(),
      ),
      GoRoute(
        path: '/journey/attraction/:id',
        builder: (context, state) => AttractionDetailView(
          attractionId: state.pathParameters['id'] ?? 'clock_tower_museum',
        ),
      ),
      GoRoute(
        path: '/journey/bookings',
        builder: (context, state) => const BookingsView(),
      ),
      GoRoute(
        path: '/journey/trip-builder',
        builder: (context, state) => const TripBuilderView(),
      ),

      // Content Sub-pages (Qur'an, Duas, Live, Articles)
      GoRoute(
        path: '/content/quran',
        builder: (context, state) => QuranIndexView(
          initialReciterId: state.uri.queryParameters['reciter'],
        ),
      ),
      GoRoute(
        path: '/content/quran/surah/:id',
        builder: (context, state) {
          final num = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
          return QuranReaderView(
            surahNumber: num,
            reciterId: state.uri.queryParameters['reciter'] ?? 'sudais',
          );
        },
      ),
      GoRoute(
        path: '/content/duas',
        builder: (context, state) => const DuasHubView(),
      ),
      GoRoute(
        path: '/content/duas/:categoryId',
        builder: (context, state) => DuaDetailView(
          categoryId: state.pathParameters['categoryId'] ?? 'morning_evening',
        ),
      ),
      GoRoute(
        path: '/content/live/:streamId',
        builder: (context, state) => LivePlayerView(
          streamId: state.pathParameters['streamId'] ?? 'makkah_live',
        ),
      ),
      GoRoute(
        path: '/content/articles',
        builder: (context, state) => const ArticlesLibraryView(),
      ),
      GoRoute(
        path: '/content/articles/:id',
        builder: (context, state) => ArticleDetailView(
          articleId: state.pathParameters['id'] ?? 'prohibitions_ihram',
        ),
      ),

      // Market Sub-pages
      GoRoute(
        path: '/market/category/:id',
        builder: (context, state) => MarketCategoryView(
          categoryId: state.pathParameters['id'] ?? 'all',
        ),
      ),
      GoRoute(
        path: '/market/product/:id',
        builder: (context, state) => ProductDetailView(
          productId: state.pathParameters['id'] ?? 'prod_zamzam_5l',
        ),
      ),
      GoRoute(
        path: '/market/cart',
        builder: (context, state) => const CartCheckoutView(),
      ),

      // Daily Knowledge Challenge Sub-App
      GoRoute(
        path: '/challenge/intro',
        builder: (context, state) => const ChallengeIntroView(),
      ),
      GoRoute(
        path: '/challenge/play',
        builder: (context, state) => const ChallengePlayView(),
      ),
      GoRoute(
        path: '/challenge/quiz/:doorId',
        builder: (context, state) => ChallengeQuizView(
          doorId: state.pathParameters['doorId'] ?? 'quran',
        ),
      ),
      GoRoute(
        path: '/challenge/winners',
        builder: (context, state) => const ChallengeWinnersView(),
      ),
      GoRoute(
        path: '/challenge/ilm',
        builder: (context, state) => const ChallengeIlmView(),
      ),
      GoRoute(
        path: '/challenge/help',
        builder: (context, state) => const ChallengeHelpView(),
      ),

      // AI Companion, Wallet, Profile
      GoRoute(
        path: '/ai',
        builder: (context, state) => const DuyaAiView(),
      ),
      GoRoute(
        path: '/wallet',
        builder: (context, state) => const WalletView(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/home'),
          child: const Text('Return Home'),
        ),
      ),
    ),
  );
}
