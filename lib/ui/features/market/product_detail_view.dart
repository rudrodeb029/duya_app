import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/market_wallet_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Market Product Detail page with delivery SLA, quantity picker & Add to Cart.
class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AuthProfileRepository>().isArabic;
    final repo = context.watch<MarketWalletRepository>();
    final product = repo.getProductById(widget.productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(product.accentHex),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Icon(Icons.inventory_2, color: Colors.white, size: 72),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            product.localizedTitle(isArabic),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${product.priceSar.toStringAsFixed(0)} SAR',
                style: const TextStyle(
                  color: DuyaColors.emerald,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              Text('★ ${product.rating}'),
            ],
          ),
          const SizedBox(height: 12),
          DuyaCard(
            color: DuyaColors.desertGoldSoft,
            child: Row(
              children: [
                const Icon(Icons.local_shipping_outlined,
                    color: DuyaColors.emerald),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${product.deliverySla} to ${repo.deliveryLocation}',
                    style: const TextStyle(
                      color: DuyaColors.textPrimaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          DuyaCard(
            child: Row(
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '$_qty',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _qty++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              repo.addToCart(product, quantity: _qty);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to your bag!')),
              );
              context.push('/market/cart');
            },
            child: Text(
              'Add to Bag • ${(product.priceSar * _qty).toStringAsFixed(0)} SAR',
            ),
          ),
        ],
      ),
    );
  }
}
