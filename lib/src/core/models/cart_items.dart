import 'package:mawad/src/core/models/products.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      throw ArgumentError(
          'A non-null map must be provided to CartItem.fromJson');
    }

    return CartItem(
      product: Product.fromJson(map['product']),
      quantity: map['quantity'] ?? 1, // Ensure that a default value exists
    );
  }

  void incrementQuantity() {
    if (quantity < product.stock) {
      quantity++;
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
