import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/market_wallet_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Filterable Market Category product listing page.
class MarketCategoryView extends StatelessWidget {
  const MarketCategoryView({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<MarketWalletRepository>();
    final products = repo.productsForCategory(categoryId);

    return DuyaSubpageScaffold(
      title: categoryId == 'all' ? 'Products' : categoryId.toUpperCase(),
      actions: [
        DuyaCircleActionButton(
          icon: Icons.shopping_bag_outlined,
          tooltip: 'Shopping Bag',
          badgeCount: repo.cartCount,
          onTap: () => context.push('/market/cart'),
        ),
      ],
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final p = products[index];
          return DuyaCard(
            onTap: () => context.push('/market/product/${p.id}'),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F3EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: DuyaColors.emerald,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.localizedTitle(isArabic),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
                      ),
                      Text(p.subtitleEn),
                      const SizedBox(height: 4),
                      Text(
                        '${p.priceSar.toStringAsFixed(0)} SAR • ★ ${p.rating}',
                        style: const TextStyle(
                          color: DuyaColors.emerald,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
