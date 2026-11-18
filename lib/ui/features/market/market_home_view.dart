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

    return DuyaDaylightBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DuyaDaylightHeader(
              title: isArabic ? 'متجر دعاء' : 'Market',
              showBack: false,
              showLogo: true,
              actions: [
                InkWell(
                  onTap: () => _pickLocation(context, repo),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F3EE),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: DuyaColors.emerald,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          repo.deliveryLocation.split('•').first.trim(),
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF136048),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DuyaCircleActionButton(
                  icon: Icons.shopping_bag_outlined,
                  tooltip: 'Shopping Bag',
                  badgeCount: repo.cartCount,
                  onTap: () => context.push('/market/cart'),
                ),
              ],
            ),
          ),
          // Zamzam Water Hero Banner
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            sliver: SliverToBoxAdapter(
              child: DuyaDaylightBannerCard(
                imageAsset: 'assets/images/promo_zamzam.jpg',
                onTap: () => context.push('/market/product/prod_zamzam_5l'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F3EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 13,
                            color: DuyaColors.emerald,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Official Haramain Sealed',
                            style: TextStyle(
                              color: DuyaColors.emerald,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 215),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Zamzam Water',
                            style: TextStyle(
                              color: Color(0xFF10553F),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Water of blessing and healing — delivered to your hotel or airport.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.push('/market/product/prod_zamzam_5l'),
                      icon: const Icon(Icons.arrow_forward, size: 17),
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
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: DuyaSectionHeader(
                title: 'Categories',
                onActionTap: () => context.push('/market/category/all'),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: repo.categories.map((cat) {
                return DuyaCard(
                  padding: const EdgeInsets.all(14),
                  onTap: () => context.push('/market/category/${cat.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F3EE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.category_outlined,
                          color: DuyaColors.emerald,
                          size: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat.localizedTitle(isArabic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                      Text(
                        cat.subtitleEn,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 10.5,
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
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                'Pilgrimage Essentials',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
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
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F3EE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: DuyaColors.emerald,
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
                                fontSize: 13.5,
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
      ),
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
