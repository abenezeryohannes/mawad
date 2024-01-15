import 'package:mawad/src/core/models/payment_mode.dart';

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

class InvoiceOrder {
  InvoiceProductOrder orders;
  List<PaymentItem> transactions;

  InvoiceOrder({
    required this.orders,
    required this.transactions,
  });

  factory InvoiceOrder.fromJson(Map<String, dynamic> json) {
    return InvoiceOrder(
      orders: InvoiceProductOrder.fromJson(json['orders']),
      transactions: List<PaymentItem>.from(json['transactions']
          .map((transaction) => PaymentItem.fromJson(transaction))),
    );
  }
}

class InvoiceProductOrder {
  String id;
  String orderId;
  List<OrderProduct> product;
  int totalPrice;

  InvoiceProductOrder({
    required this.id,
    required this.orderId,
    required this.product,
    required this.totalPrice,
  });

  factory InvoiceProductOrder.fromJson(Map<String, dynamic> json) {
    return InvoiceProductOrder(
      id: json['id'],
      orderId: json['orderId'],
      product: List<OrderProduct>.from(
          json['product'].map((product) => OrderProduct.fromJson(product))),
      totalPrice: json['totalPrice'],
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

class PaymentItem {
  bool isPaid;
  double price;
  double? totalPrice;
  List<InvoiceService>? service;
  int percentage;
  int index;
  bool permission;

  PaymentItem({
    required this.isPaid,
    required this.price,
    this.totalPrice,
    this.service,
    required this.percentage,
    required this.index,
    required this.permission,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return PaymentItem(
      isPaid: json['isPaid'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      service: json['service'] != null
          ? List<InvoiceService>.from(
              json['service'].map((s) => InvoiceService.fromJson(s)))
          : null,
      percentage: json['percentage'],
      index: json['index'],
      permission: json['permission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPaid': isPaid,
      'price': price,
      'totalPrice': totalPrice,
      'service': service?.map((s) => s.toJson()).toList(),
      'percentage': percentage,
      'index': index,
      'permission': permission,
    };
  }
}
