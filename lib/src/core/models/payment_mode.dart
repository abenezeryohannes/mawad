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
