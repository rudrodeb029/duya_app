import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/market_wallet_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Duya Market home tab: Delivery location pill, Cart badge, Zamzam Water hero,
/// category tiles, and curated pilgrimage essentials.
class MarketHomeView extends StatelessWidget {
  const MarketHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<MarketWalletRepository>();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          isArabic ? 'متجر دعاء' : 'Duya Market',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      InkWell(
                        onTap: () => _pickLocation(context, repo),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                repo.deliveryLocation.split('•').first.trim(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => context.push('/market/cart'),
                        icon: Badge.count(
                          count: repo.cartCount,
                          isLabelVisible: repo.cartCount > 0,
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Zamzam Water Hero Banner
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 230,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E755F), Color(0xFF348E76)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.water_drop, color: DuyaColors.desertGoldSoft),
                      SizedBox(width: 8),
                      Text(
                        'Official Haramain Sealed',
                        style: TextStyle(
                          color: DuyaColors.desertGoldSoft,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'Zamzam Water',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Water of blessing and healing — delivered to your hotel or airport.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.push('/market/product/prod_zamzam_5l'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DuyaColors.desertGold,
                      foregroundColor: DuyaColors.celestialNight,
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    label: const Text('Order Zamzam Water'),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Categories Grid
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
            child: DuyaSectionHeader(
              title: 'Categories',
              onActionTap: () => context.push('/market/category/all'),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: repo.categories.map((cat) {
              return DuyaCard(
                onTap: () => context.push('/market/category/${cat.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category_outlined, color: Color(cat.accentHex)),
                    const SizedBox(height: 8),
                    Text(
                      cat.localizedTitle(isArabic),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                      ),
                    ),
                    Text(
                      cat.subtitleEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 11.5,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        // Featured Products
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
            child: Text(
              'Pilgrimage Essentials',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
          sliver: SliverList.separated(
            itemCount: repo.products.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final prod = repo.products[index];
              return DuyaCard(
                onTap: () => context.push('/market/product/${prod.id}'),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(prod.accentHex),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prod.localizedTitle(isArabic),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            prod.deliverySla,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${prod.priceSar.toStringAsFixed(0)} SAR',
                            style: const TextStyle(
                              color: DuyaColors.emerald,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        repo.addToCart(prod);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${prod.titleEn} added')),
                        );
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: DuyaColors.emerald,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _pickLocation(BuildContext context, MarketWalletRepository repo) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'Makkah • Jabal Omar Area',
          'Madinah • Central Haram Area',
          'Jeddah • King Abdulaziz Airport',
        ]
            .map(
              (loc) => ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(loc),
                onTap: () {
                  repo.setDeliveryLocation(loc);
                  Navigator.of(ctx).pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
