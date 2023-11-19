import 'package:mawad/src/core/enums/paymentType.dart';

class PaymentMethods {
  final int id;
  final bool knet;
  final bool card;
  final bool cash;

  PaymentMethods({
    required this.id,
    required this.knet,
    required this.card,
    required this.cash,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) {
    return PaymentMethods(
      id: json['id'],
      knet: json['knet'],
      card: json['card'],
      cash: json['cash'],
    );
  }
}

class PaymentTypeMode {
  final String id;
  final String icon;
  final PaymentType name;
  bool isAvailable = false;

  PaymentTypeMode({
    required this.id,
    required this.icon,
    required this.name,
    this.isAvailable = false,
  });
}

class PaymentInfo {
  final String id;
  final String orderId;
  final String payLink;

  PaymentInfo({
    required this.id,
    required this.orderId,
    required this.payLink,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      payLink: json['payLink'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'payLink': payLink,
    };
  }
}
