import 'package:flutter/foundation.dart';

import '../../domain/models/market_models.dart';
import '../../domain/models/user_wallet_models.dart';

/// Repository managing Duya Market catalog, Cart, Orders, and Travel Wallet.
class MarketWalletRepository extends ChangeNotifier {
  String _deliveryLocation = 'Makkah • Jabal Omar Area';
  String get deliveryLocation => _deliveryLocation;

  final List<CartItem> _cart = [];
  List<CartItem> get cart => List.unmodifiable(_cart);

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotalSar =>
      _cart.fold(0, (sum, item) => sum + item.lineTotalSar);

  final List<MarketOrder> _orders = [];
  List<MarketOrder> get orders => List.unmodifiable(_orders);

  double _walletBalanceSar = 22060.0;
  double get walletBalanceSar => _walletBalanceSar;

  String _displayCurrency = 'SAR';
  String get displayCurrency => _displayCurrency;

  static const Map<String, double> currencyRates = {
    'SAR': 1.0,
    'USD': 0.2666,
    'EUR': 0.245,
    'GBP': 0.21,
    'BDT': 31.8,
  };

  final List<WalletTransaction> _transactions = [
    const WalletTransaction(
      id: 'tx_1',
      title: 'Hotel Deposit • Makkah',
      dateLabel: '14 Jan 2026 • 09:45',
      amountSar: 1750,
      isCredit: false,
      category: 'Payment',
    ),
    const WalletTransaction(
      id: 'tx_2',
      title: 'Internal Wallet Transfer',
      dateLabel: '28 Mar 2026 • 13:00',
      amountSar: 2500,
      isCredit: true,
      category: 'Internal Transfer',
    ),
    const WalletTransaction(
      id: 'tx_3',
      title: 'International Card Top-Up',
      dateLabel: '22 Feb 2026 • 14:20',
      amountSar: 2100,
      isCredit: true,
      category: 'International Transfer',
    ),
  ];
  List<WalletTransaction> get transactions => List.unmodifiable(_transactions);

  double get convertedBalance =>
      _walletBalanceSar * (currencyRates[_displayCurrency] ?? 1.0);

  void setDeliveryLocation(String location) {
    _deliveryLocation = location;
    notifyListeners();
  }

  void setDisplayCurrency(String currency) {
    if (currencyRates.containsKey(currency)) {
      _displayCurrency = currency;
      notifyListeners();
    }
  }

  void topUpWallet(double amountSar, {String source = 'Instant Top-Up'}) {
    if (amountSar <= 0) return;
    _walletBalanceSar += amountSar;
    _transactions.insert(
      0,
      WalletTransaction(
        id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
        title: source,
        dateLabel: 'Today • Just now',
        amountSar: amountSar,
        isCredit: true,
        category: 'Top-Up',
      ),
    );
    notifyListeners();
  }

  void debitWallet(double amountSar, String title) {
    _walletBalanceSar = (_walletBalanceSar - amountSar).clamp(0, double.infinity);
    _transactions.insert(
      0,
      WalletTransaction(
        id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        dateLabel: 'Today • Just now',
        amountSar: amountSar,
        isCredit: false,
        category: 'Payment',
      ),
    );
    notifyListeners();
  }

  void addToCart(MarketProduct product, {int quantity = 1}) {
    final idx = _cart.indexWhere((c) => c.product.id == product.id);
    if (idx >= 0) {
      _cart[idx] = _cart[idx].copyWith(quantity: _cart[idx].quantity + quantity);
    } else {
      _cart.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final idx = _cart.indexWhere((c) => c.product.id == productId);
    if (idx < 0) return;
    if (quantity <= 0) {
      _cart.removeAt(idx);
    } else {
      _cart[idx] = _cart[idx].copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  MarketOrder checkout({required String paymentMethod}) {
    final total = cartTotalSar;
    final itemsSnapshot = List<CartItem>.from(_cart);
    final order = MarketOrder(
      id: 'ORD-${1000 + _orders.length * 37}',
      items: itemsSnapshot,
      deliveryLocation: _deliveryLocation,
      totalSar: total,
      paymentMethod: paymentMethod,
      status: 'Preparing for Delivery',
      createdAt: DateTime.now(),
    );
    if (paymentMethod == 'Duya Wallet' && total > 0) {
      debitWallet(total, 'Duya Market • ${order.id}');
    }
    _orders.insert(0, order);
    _cart.clear();
    notifyListeners();
    return order;
  }

  List<MarketCategory> get categories => const [
        MarketCategory(
          id: 'zamzam',
          titleEn: 'Zamzam Water',
          titleAr: 'ماء زمزم',
          subtitleEn: 'Official sealed cartons & bottles',
          accentHex: 0xFF217865,
        ),
        MarketCategory(
          id: 'ihram',
          titleEn: 'Ihram & Apparel',
          titleAr: 'ملابس الإحرام',
          subtitleEn: 'Breathable organic cotton kits',
          accentHex: 0xFF0E4D3B,
        ),
        MarketCategory(
          id: 'prayer',
          titleEn: 'Prayer Mats & Tasbih',
          titleAr: 'سجادات ومسابح',
          subtitleEn: 'Rawdah-inspired cushioned mats',
          accentHex: 0xFFC99A3B,
        ),
        MarketCategory(
          id: 'dates',
          titleEn: 'Madinah Dates & Gifts',
          titleAr: 'تمور المدينة والهدايا',
          subtitleEn: 'Ajwa Al-Madinah & gift boxes',
          accentHex: 0xFF6B4C3B,
        ),
      ];

  List<MarketProduct> get products => const [
        MarketProduct(
          id: 'prod_zamzam_5l',
          categoryId: 'zamzam',
          titleEn: 'Official Zamzam Water (5L Travel Carton)',
          titleAr: 'عبوة ماء زمزم الرسمية (٥ لتر)',
          subtitleEn: 'Water of blessing and healing • Airport & Hotel sealed',
          description:
              'Official Ministry-approved 5-liter sealed Zamzam carton packaged for safe hotel delivery or checked airline luggage.',
          priceSar: 15,
          rating: 5.0,
          deliverySla: 'Same-day delivery in Makkah & Madinah',
          isFeatured: true,
          accentHex: 0xFF217865,
        ),
        MarketProduct(
          id: 'prod_zamzam_pack',
          categoryId: 'zamzam',
          titleEn: 'Chilled Zamzam 12-Bottle Pack (330ml)',
          titleAr: 'كرتون زمزم (١٢ عبوة مبردة)',
          subtitleEn: 'Convenient room hydration for families',
          description:
              'Twelve sealed 330ml Zamzam bottles delivered directly to your Makkah or Madinah hotel reception.',
          priceSar: 28,
          rating: 4.9,
          deliverySla: '2-hour express hotel drop',
          isFeatured: false,
          accentHex: 0xFF2A8772,
        ),
        MarketProduct(
          id: 'prod_ihram_cotton',
          categoryId: 'ihram',
          titleEn: 'Pure Combed Cotton Ihram Set + Belt',
          titleAr: 'طقم إحرام قطن فاخر مع حزام',
          subtitleEn: 'Ultra-soft lightweight weave for warm weather',
          description:
              'Two-piece 100% breathable combed cotton Ihram set paired with a secure anti-theft waist belt.',
          priceSar: 85,
          rating: 4.8,
          deliverySla: 'Delivered within 3 hours',
          isFeatured: true,
          accentHex: 0xFF0E4D3B,
        ),
        MarketProduct(
          id: 'prod_rawdah_mat',
          categoryId: 'prayer',
          titleEn: 'Al-Rawdah Memory Foam Prayer Mat',
          titleAr: 'سجادة صلاة بتصميم الروضة',
          subtitleEn: 'Foldable travel pouch • Emerald weave',
          description:
              'Inspired by the emerald carpets of Al-Rawdah Al-Sharifah with ergonomic cushioning and compact travel strap.',
          priceSar: 95,
          rating: 4.9,
          deliverySla: 'Next-day or hotel lobby pickup',
          isFeatured: true,
          accentHex: 0xFF0E4D3B,
        ),
        MarketProduct(
          id: 'prod_ajwa_box',
          categoryId: 'dates',
          titleEn: 'Premium Ajwa Al-Madinah Gift Box (1kg)',
          titleAr: 'صندوق تمر عجوة المدينة الفاخر',
          subtitleEn: 'Harvested from Madinah Al-Munawwarah farms',
          description:
              'Hand-sorted soft Ajwa dates packed in a keepsake gold-embossed box ideal for family gifts.',
          priceSar: 120,
          rating: 4.9,
          deliverySla: 'Same-day Madinah • Next-day Makkah',
          isFeatured: false,
          accentHex: 0xFF6B4C3B,
        ),
      ];

  List<MarketProduct> productsForCategory(String categoryId) {
    if (categoryId == 'all') return products;
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  MarketProduct getProductById(String id) {
    return products.firstWhere(
      (p) => p.id == id,
      orElse: () => products.first,
    );
  }
}
