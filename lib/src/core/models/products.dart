import 'package:mawad/src/core/models/catagorie.dart';
import 'package:mawad/src/core/models/image_model.dart';
import 'package:mawad/src/core/models/product_addon.dart';

class Product {
  final String id;
  final int index;
  final int? ordersCount;
  final bool status;
  final int salesCount;
  final String? label;
  final List<CategoryModel> categories;
  final bool showStock;
  final List<ProductAddon> productAddons;
  final String nameAr;
  final String nameEng;
  final String detailsAr;
  final String detailsEng;
  final double price;
  final int stock;
  final double tax;
  final List<ImageModel> images;
  final String? itemCode;
  final double oldPrice;
  final String additionalInformationAr;
  final String additionalInformationEng;
  final bool allowStock;
  final bool outOfStock;
  final bool allowBaseTax;
  final bool allowInstructions;
  final List<dynamic> promotions;

  Product({
    required this.id,
    required this.index,
    required this.ordersCount,
    required this.status,
    required this.salesCount,
    this.label,
    required this.categories,
    required this.showStock,
    required this.productAddons,
    required this.nameAr,
    required this.nameEng,
    required this.detailsAr,
    required this.detailsEng,
    required this.price,
    required this.stock,
    required this.tax,
    required this.images,
    this.itemCode,
    required this.oldPrice,
    required this.additionalInformationAr,
    required this.additionalInformationEng,
    required this.allowStock,
    required this.outOfStock,
    required this.allowBaseTax,
    required this.allowInstructions,
    required this.promotions,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      index: json['index'],
      ordersCount: json['ordersCount'] ?? 0,
      status: json['status'],
      salesCount: json['salesCount'],
      label: json['label'],
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
      showStock: json['showStock'],
      productAddons: (json['productAddons'] as List<dynamic>? ?? [])
          .map((addon) => ProductAddon.fromJson(addon))
          .toList(),
      nameAr: json['nameAr'] ?? '',
      nameEng: json['nameEng'] ?? '',
      detailsAr: json['detailsAr'] ?? '',
      detailsEng: json['detailsEng'] ?? '',
      price: json['price'].toDouble(),
      stock: json['stock'],
      tax: json['tax'].toDouble(),
      images: (json['images'] as List<dynamic>? ?? [])
          .map((image) => ImageModel.fromJson(image))
          .toList(),
      itemCode: json['itemCode'],
      oldPrice: json['oldPrice'].toDouble(),
      additionalInformationAr: json['additionalInformationAr'] ?? '',
      additionalInformationEng: json['additionalInformationEng'] ?? '',
      allowStock: json['allowStock'],
      outOfStock: json['outOfStock'],
      allowBaseTax: json['allowBaseTax'],
      allowInstructions: json['allowInstructions'],
      promotions: json['promotions'] as List<dynamic>? ?? [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'ordersCount': ordersCount,
      'status': status,
      'salesCount': salesCount,
      'label': label,
      'categories': categories.map((category) => category.toMap()).toList(),
      'showStock': showStock,

      'nameAr': nameAr,
      'nameEng': nameEng,
      'detailsAr': detailsAr,
      'detailsEng': detailsEng,
      'price': price,
      'stock': stock,
      'tax': tax,
      'images': images.map((image) => image.toMap()).toList(),
      'itemCode': itemCode,
      'oldPrice': oldPrice,
      'additionalInformationAr': additionalInformationAr,
      'additionalInformationEng': additionalInformationEng,
      'allowStock': allowStock,
      'outOfStock': outOfStock,
      'allowBaseTax': allowBaseTax,
      'allowInstructions': allowInstructions,
      'promotions':
          promotions, // Assuming promotions is a List of primitives (like int, String etc.)
    };
  }
}
