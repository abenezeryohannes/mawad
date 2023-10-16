import 'package:get/get.dart';
import 'package:mawad/src/core/models/product.dart';

class ProductController extends GetxController {
  List<Product> sampleProduct = [
    Product(
        id: '1',
        name: 'Sample Product 1',
        description: 'This is a sample product description.',
        price: 55.00,
        imagePath: 'assets/icon/banner.png',
        isFavorite: false),
    Product(
        id: '2',
        name: 'Sample Product 2',
        description: 'This is a sample product description.',
        price: 55.00,
        imagePath: 'assets/icon/banner.png',
        isFavorite: false),
    Product(
        id: '3',
        name: 'Sample Product 3',
        description: 'This is a sample product description.',
        price: 55.00,
        imagePath: 'assets/icon/banner.png',
        isFavorite: false)
  ].obs;

  void toggleFavorite(String productId) {
    for (var product in sampleProduct) {
      if (product.id == productId) {
        product.isFavorite = !product.isFavorite;
        update(); // Notify listeners about the change.
        break;
      }
    }
  }
}
