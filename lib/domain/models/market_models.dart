/// Immutable domain models for Duya Market products, categories, cart & orders.
class MarketCategory {
  const MarketCategory({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.accentHex,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final int accentHex;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}

class MarketProduct {
  const MarketProduct({
    required this.id,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.description,
    required this.priceSar,
    required this.rating,
    required this.deliverySla,
    required this.isFeatured,
    required this.accentHex,
  });

  final String id;
  final String categoryId;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String description;
  final double priceSar;
  final double rating;
  final String deliverySla;
  final bool isFeatured;
  final int accentHex;

  String localizedTitle(bool isArabic) => isArabic ? titleAr : titleEn;
}

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final MarketProduct product;
  final int quantity;

  double get lineTotalSar => product.priceSar * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}

class MarketOrder {
  const MarketOrder({
    required this.id,
    required this.items,
    required this.deliveryLocation,
    required this.totalSar,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final List<CartItem> items;
  final String deliveryLocation;
  final double totalSar;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;
}
