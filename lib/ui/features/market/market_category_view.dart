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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryId == 'all' ? 'All Products' : categoryId.toUpperCase(),
        ),
        actions: [
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
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final p = products[index];
          return DuyaCard(
            onTap: () => context.push('/market/product/${p.id}'),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(p.accentHex),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.shopping_bag, color: Colors.white),
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
                          fontSize: 15.5,
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
