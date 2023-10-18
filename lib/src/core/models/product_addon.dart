class ProductAddon {
  final List<Modifier> modifiers;
  final String id;
  final int index;
  final bool status;
  final String addonOption;
  final int maxAllowed;
  final int minAllowed;
  final String nameAr;
  final String nameEng;
  final String? detailsAr;
  final String? detailsEng;
  final bool required;
  final bool showColors;
  final bool expanded;

  ProductAddon({
    required this.modifiers,
    required this.id,
    required this.index,
    required this.status,
    required this.addonOption,
    required this.maxAllowed,
    required this.minAllowed,
    required this.nameAr,
    required this.nameEng,
    this.detailsAr,
    this.detailsEng,
    required this.required,
    required this.showColors,
    required this.expanded,
  });

  factory ProductAddon.fromJson(Map<String, dynamic> json) {
    return ProductAddon(
      modifiers: (json['modifiers'] as List)
          .map((modifier) => Modifier.fromJson(modifier))
          .toList(),
      id: json['id'],
      index: json['index'],
      status: json['status'],
      addonOption: json['addonOption'],
      maxAllowed: json['maxAllowed'],
      minAllowed: json['minAllowed'],
      nameAr: json['nameAr'],
      nameEng: json['nameEng'],
      detailsAr: json['detailsAr'],
      detailsEng: json['detailsEng'],
      required: json['required'],
      showColors: json['showColors'],
      expanded: json['expanded'],
    );
  }
}

class Modifier {
  final String id;
  final int index;
  final String nameAr;
  final String nameEng;
  final String? detailsAr;
  final String? detailsEng;
  final bool hasStock;
  final String color;
  final double price;
  final int stock;
  final ProductAddon productAddon; // Recursive structure
  final List<dynamic>
      modifierTags; // Use a specific model if you know the structure of the tags

  Modifier({
    required this.id,
    required this.index,
    required this.nameAr,
    required this.nameEng,
    this.detailsAr,
    this.detailsEng,
    required this.hasStock,
    required this.color,
    required this.price,
    required this.stock,
    required this.productAddon,
    required this.modifierTags,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) {
    return Modifier(
      id: json['id'],
      index: json['index'],
      nameAr: json['nameAr'],
      nameEng: json['nameEng'],
      detailsAr: json['detailsAr'],
      detailsEng: json['detailsEng'],
      hasStock: json['hasStock'],
      color: json['color'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      productAddon: ProductAddon.fromJson(json['productAddon']),
      modifierTags: json['modifierTags'],
    );
  }
}
