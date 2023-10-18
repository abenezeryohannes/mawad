import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/favorites_service.dart';

class FavoritesController extends GetxController {
  final FavoritesService _service = FavoritesService();
  final RxList<Product> favorites = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    log(favorites.toString());
  }

  void loadFavorites() async {
    favorites.addAll(await _service.getFavorites()); // Changed method name
  }

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  void toggleFavorite(Product product) async {
    if (isFavorite(product)) {
      await _service.removeFavorite(product);
      favorites.remove(product);
    } else {
      await _service.addFavorite(product);
      favorites.add(product);
    }
  }
}
