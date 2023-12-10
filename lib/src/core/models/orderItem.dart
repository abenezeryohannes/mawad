class OrderItem {
  final String id;
  final String orderId;
  final String cratedAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.cratedAt,
  });

  //to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'cratedAt': cratedAt,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['orderId'],
      cratedAt: json['cratedAt'],
    );
  }
}

class OrderProduct {
  final String id;
  final String nameAr;
  final String nameEng;
  final List<String> images;

  OrderProduct({
    required this.id,
    required this.nameAr,
    required this.nameEng,
    required this.images,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEng: json['nameEng'],
      images: List<String>.from(json['images']),
    );
  }
}

class PriceDetail {
  final double price;
  final int percentage;
  final int index;
  final bool permission;

  PriceDetail({
    required this.price,
    required this.percentage,
    required this.index,
    required this.permission,
  });

  factory PriceDetail.fromJson(Map<String, dynamic> json) {
    return PriceDetail(
      price: json['price'].toDouble(),
      percentage: json['percentage'],
      index: json['index'],
      permission: json['permission'],
    );
  }
}
