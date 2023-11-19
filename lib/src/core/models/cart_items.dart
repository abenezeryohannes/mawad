import 'package:mawad/src/core/models/products.dart';

class CartItem {
  String? id;
  Product product;
  int quantity;
  List<Addon> attributes;
  String? comment;
  double price;
  double taxPrice;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.comment,
    required this.price,
    this.taxPrice = 0.0,
    List<Addon>? attributes,
  }) : attributes = attributes ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': product.id,
      'product': product.toMap(),
      'quantity': quantity,
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'comment': comment ?? '',
      'price': price,
      'taxPrice': taxPrice,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      throw ArgumentError(
          'A non-null map must be provided to CartItem.fromJson');
    }

    return CartItem(
      product: Product.fromJson(map['product']),
      quantity: map['quantity'] ?? 1,
      comment: map['comment'] ?? '',
      price: map['price'] ?? 0.0,
      taxPrice: map['taxPrice'] ?? 0.0,
      attributes: List<Addon>.from(
          map['attributes']?.map((attr) => Addon.fromJson(attr)) ?? []),
    );
  }
}

class Addon {
  String addonId;
  List<ModifierCart> modifiers;

  Addon({required this.addonId, required this.modifiers});

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      addonId: json['addonId'],
      modifiers: List<ModifierCart>.from(
          json['modifiers'].map((modifier) => ModifierCart.fromJson(modifier))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addonId': addonId,
      'modifiers': modifiers.map((modifier) => modifier.toJson()).toList(),
    };
  }
}

class ModifierCart {
  String modifierId;
  int count;
  List<ModifierChoice> modifierChoice;

  ModifierCart({
    required this.modifierId,
    required this.count,
    required this.modifierChoice,
  });

  factory ModifierCart.fromJson(Map<String, dynamic> json) {
    return ModifierCart(
      modifierId: json['modifierId'],
      count: json['count'],
      modifierChoice: List<ModifierChoice>.from(
        json['modifierChoice'].map((choice) => ModifierChoice.fromJson(choice)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modifierId': modifierId,
      'count': count,
      'modifierChoice':
          modifierChoice.map((choice) => choice.toJson()).toList(),
    };
  }
}

class ModifierChoice {
  String choseAddonId;
  List<ModifierDetail> modifier;

  ModifierChoice({
    required this.choseAddonId,
    required this.modifier,
  });

  factory ModifierChoice.fromJson(Map<String, dynamic> json) {
    return ModifierChoice(
      choseAddonId: json['choseAddonId'],
      modifier: List<ModifierDetail>.from(
        json['modifier'].map((detail) => ModifierDetail.fromJson(detail)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choseAddonId': choseAddonId,
      'modifier': modifier.map((detail) => detail.toJson()).toList(),
    };
  }
}

class ModifierDetail {
  String id;
  int count;

  ModifierDetail({
    required this.id,
    required this.count,
  });

  factory ModifierDetail.fromJson(Map<String, dynamic> json) {
    return ModifierDetail(
      id: json['id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
    };
  }
}
