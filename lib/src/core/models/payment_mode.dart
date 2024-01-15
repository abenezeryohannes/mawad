class PaymentPercentage {
  final String id;
  final List<Percentage> items;

  PaymentPercentage({required this.id, required this.items});

  factory PaymentPercentage.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsList = json['items'];
    List<Percentage> parsedItems = List<Percentage>.from(
        itemsList.map((item) => Percentage.fromJson(item)));

    return PaymentPercentage(id: json['id'], items: parsedItems);
  }
}

class Percentage {
  final String id;
  final int index;
  final int percentage;

  Percentage({required this.id, required this.index, required this.percentage});

  factory Percentage.fromJson(Map<String, dynamic> json) {
    return Percentage(
      id: json['id'],
      index: json['index'],
      percentage: json['percentage'],
    );
  }
}

class CaluatePayment {
  List<ProductPayment> products;
  List<String> services;

  CaluatePayment({required this.products, required this.services});

  factory CaluatePayment.fromJson(Map<String, dynamic> json) {
    return CaluatePayment(
      products: List<ProductPayment>.from(
          json['product'].map((product) => ProductPayment.fromJson(product))),
      services: List<String>.from(json['services']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': products.map((product) => product.toJson()).toList(),
      'services': services,
    };
  }
}

class ProductPayment {
  String id;
  int quantity;

  ProductPayment({required this.id, required this.quantity});

  factory ProductPayment.fromJson(Map<String, dynamic> json) {
    return ProductPayment(
      id: json['id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}

class Invoice {
  String id;
  List<InvoiceItem> items;

  Invoice({required this.id, required this.items});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      items: List<InvoiceItem>.from(
          json['items'].map((item) => InvoiceItem.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class InvoiceItem {
  double price;
  double? totalPrice;
  int percentage;
  int index;
  List<InvoiceService>? service;

  InvoiceItem(
      {required this.price,
      this.totalPrice,
      required this.percentage,
      required this.index,
      this.service});

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      price: json['price'],
      totalPrice: json['totalPrice'],
      percentage: json['percentage'],
      index: json['index'],
      service: json['service'] != null
          ? List<InvoiceService>.from(
              json['service'].map((s) => InvoiceService.fromJson(s)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'totalPrice': totalPrice,
      'percentage': percentage,
      'index': index,
      'service': service?.map((s) => s.toJson()).toList(),
    };
  }
}

class InvoiceService {
  String id;
  int price;
  String title;

  InvoiceService({required this.id, required this.price, required this.title});

  factory InvoiceService.fromJson(Map<String, dynamic> json) {
    return InvoiceService(
      id: json['id'],
      price: json['price'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'title': title,
    };
  }
}
