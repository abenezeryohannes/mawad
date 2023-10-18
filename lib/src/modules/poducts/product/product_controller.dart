import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/models/catagorie.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/repositories/produact_category_repo.dart';
import 'package:mawad/src/data/repositories/products.dart';
import 'package:mawad/src/data/services/recaptcha_token.dart';

class ProductController extends GetxController {
  final recaptchaService = ReCaptchaV3Service(
      '6Le73mIgAAAAAHAcNOnzqRHPsQVnS-EiTjG7KYQW', 'YOUR_ACTION');
  final ProductsRepo _productsRepo = ProductsRepo();
  final ProductCategoryRepo _productCategoryRepo = ProductCategoryRepo();
  final products = <Product>[].obs;
  final categories = <CategoryModel>[].obs;

  Future<String?> getReca() async {
    final token = await recaptchaService.getRecaptchaV3Token();
    log(token.toString());
    return token;
  }

  void getProductByCountry(String id) async {
    try {
      final productsData = await _productsRepo.getProductByCountry(id);
      products.value = productsData.obs;
    } catch (error) {
      // Handle error here
    }
  }

  void getCategoryByCountry(String id) async {
    try {
      final productsData = await _productCategoryRepo.getCategory(id);
      categories.value = productsData.obs;
    } catch (error) {
      // Handle error here
    }
  }
  // List<Product> sampleProduct = [
  //   Product(
  //       id: '1',
  //       name: 'Sample Product 1',
  //       description: 'This is a sample product description.',
  //       price: 55.00,
  //       imagePath: 'assets/icon/banner.png',
  //       isFavorite: false),
  //   Product(
  //       id: '2',
  //       name: 'Sample Product 2',
  //       description: 'This is a sample product description.',
  //       price: 55.00,
  //       imagePath: 'assets/icon/banner.png',
  //       isFavorite: false),
  //   Product(
  //       id: '3',
  //       name: 'Sample Product 3',
  //       description: 'This is a sample product description.',
  //       price: 55.00,
  //       imagePath: 'assets/icon/banner.png',
  //       isFavorite: false)
  // ].obs;
}
