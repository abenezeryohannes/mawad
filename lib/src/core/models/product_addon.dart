class ProductAddons {
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

  ProductAddons({
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

  factory ProductAddons.fromJson(Map<String, dynamic> json) {
    return ProductAddons(
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
  final List<ModifierTag>
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
      modifierTags: (json['modifierTags'] as List)
          .map((modifier) => ModifierTag.fromJson(modifier))
          .toList(),
    );
  }
}

class ProductAddon {
  final String id;
  final String nameAr;
  final String nameEng;

  ProductAddon({
    required this.id,
    required this.nameAr,
    required this.nameEng,
  });

  factory ProductAddon.fromJson(Map<String, dynamic> json) {
    return ProductAddon(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
    );
  }
}

class ModifierTag {
  String id;
  int index;
  bool status;
  int maxAllowed;
  int minAllowed;
  String nameAr;
  String nameEng;
  String detailsAr;
  String detailsEng;
  bool required;
  bool showColors;
  List<ProductModifierChoice> productModifierChoice;
  ProductModifier productModifier;
  String option;
  bool expanded;

  ModifierTag({
    required this.id,
    required this.index,
    required this.status,
    required this.maxAllowed,
    required this.minAllowed,
    required this.nameAr,
    required this.nameEng,
    required this.detailsAr,
    required this.detailsEng,
    required this.required,
    required this.showColors,
    required this.productModifierChoice,
    required this.productModifier,
    required this.option,
    required this.expanded,
  });

  factory ModifierTag.fromJson(Map<String, dynamic> json) => ModifierTag(
        id: json['id'],
        index: json['index'],
        status: json['status'],
        maxAllowed: json['maxAllowed'],
        minAllowed: json['minAllowed'],
        nameAr: json['nameAr'],
        nameEng: json['nameEng'],
        detailsAr: json['detailsAr'],
        detailsEng: json['detailsEng'],
        required: json['required'],
        showColors: json['showColors'],
        productModifierChoice: List<ProductModifierChoice>.from(
            json['productModifierChoice']
                .map((x) => ProductModifierChoice.fromJson(x))),
        productModifier: ProductModifier.fromJson(json['productModifier']),
        option: json['option'],
        expanded: json['expanded'],
      );
}

class ProductModifierChoice {
  String id;
  int index;
  String nameAr;
  String nameEng;
  String? detailsAr;
  String? detailsEng;
  bool hasStock;
  String color;
  double price;
  int stock;

  ProductModifierChoice({
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
  });

  factory ProductModifierChoice.fromJson(Map<String, dynamic> json) =>
      ProductModifierChoice(
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
      );
}

class ProductModifier {
  ProductAddon productAddon;

  ProductModifier({
    required this.productAddon,
  });

  factory ProductModifier.fromJson(Map<String, dynamic> json) =>
      ProductModifier(
        productAddon: ProductAddon.fromJson(json['productAddon']),
      );
}
