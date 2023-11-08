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
  final String name;

  PaymentTypeMode({
    required this.id,
    required this.icon,
    required this.name,
  });
}
