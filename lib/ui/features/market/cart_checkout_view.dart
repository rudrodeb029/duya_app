import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/market_wallet_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Shopping Bag, Checkout with Duya Wallet or Card, and Market Order History.
class CartCheckoutView extends StatefulWidget {
  const CartCheckoutView({super.key});

  @override
  State<CartCheckoutView> createState() => _CartCheckoutViewState();
}

class _CartCheckoutViewState extends State<CartCheckoutView> {
  String _paymentMethod = 'Duya Wallet';

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<MarketWalletRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bag & Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (repo.cart.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Center(
                child: Text('Your bag is empty. Add Zamzam or essentials!'),
              ),
            )
          else ...[
            ...repo.cart.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DuyaCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.titleEn,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${item.lineTotalSar.toStringAsFixed(0)} SAR',
                              style: const TextStyle(color: DuyaColors.emerald),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => repo.updateQuantity(
                          item.product.id,
                          item.quantity - 1,
                        ),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        onPressed: () => repo.updateQuantity(
                          item.product.id,
                          item.quantity + 1,
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            DuyaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery: ${repo.deliveryLocation}'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _paymentMethod,
                    decoration: const InputDecoration(labelText: 'Payment Method'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Duya Wallet',
                        child: Text('Duya Wallet'),
                      ),
                      DropdownMenuItem(
                        value: 'Card / Apple Pay',
                        child: Text('Card / Apple Pay'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _paymentMethod = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${repo.cartTotalSar.toStringAsFixed(0)} SAR',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: DuyaColors.emerald,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final order = repo.checkout(paymentMethod: _paymentMethod);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order ${order.id} placed successfully!'),
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
          if (repo.orders.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Recent Orders',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...repo.orders.map(
              (o) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DuyaCard(
                  color: DuyaColors.successSoft,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.local_shipping,
                      color: DuyaColors.emerald,
                    ),
                    title: Text('${o.id} • ${o.totalSar.toStringAsFixed(0)} SAR'),
                    subtitle: Text('${o.status} • ${o.deliveryLocation}'),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
