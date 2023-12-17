class OrderItem {
  final String id;
  final String orderId;
  final String createdAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.createdAt,
  });

  //to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'createdAt': createdAt,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['orderId'],
      createdAt: json['createdAt'],
    );
  }
}

class OrderProduct {
  String id;
  double price;
  String nameAr;
  String nameEng;
  List<String> images;

  OrderProduct({
    required this.id,
    required this.price,
    required this.nameAr,
    required this.nameEng,
    required this.images,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      price: json['price'].toDouble(),
      nameAr: json['nameAr'],
      nameEng: json['nameEng'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'nameAr': nameAr,
      'nameEng': nameEng,
      'images': images,
    };
  }
}

class OrderDetail {
  List<OrderProduct> product;
  double totalPrice;
  String orderId;
  List<PriceDetail> priceDetail;

  OrderDetail({
    required this.product,
    required this.totalPrice,
    required this.orderId,
    required this.priceDetail,
  });

  //empty constructor
  OrderDetail.empty()
      : product = [],
        totalPrice = 0.0,
        orderId = '',
        priceDetail = [];

  factory OrderDetail.fromJson(List<dynamic> json) {
    final productDetails = json[0];
    final priceDetailsJson = json[1];

    return OrderDetail(
      product: List<OrderProduct>.from(productDetails['product']
          .map((productJson) => OrderProduct.fromJson(productJson))),
      totalPrice: productDetails['totalPrice'].toDouble(),
      orderId: productDetails['orderId'],
      priceDetail: List<PriceDetail>.from(priceDetailsJson
          .map((percentageJson) => PriceDetail.fromJson(percentageJson))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
      'orderId': orderId,
    };
  }
}

class PriceDetail {
  double price;
  double percentage;
  int index;
  bool permission;

  PriceDetail({
    required this.price,
    required this.percentage,
    required this.index,
    required this.permission,
  });

  factory PriceDetail.fromJson(Map<String, dynamic> json) {
    return PriceDetail(
      price: json['price'].toDouble(),
      percentage: json['percentage'].toDouble(),
      index: json['index'],
      permission: json['permission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'percentage': percentage,
      'index': index,
      'permission': permission,
    };
  }
}
