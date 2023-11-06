import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/repositories/favorite_repo.dart';

class FavoritesController extends GetxController {
  final FavoritesRepository _repository = FavoritesRepository();
  final RxList<Product> favorites = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() async {
    try {
      var fetchedFavorites = await _repository.getFavorites();
      favorites.assignAll(fetchedFavorites);
    } catch (e) {
      log('Failed to load favorites: $e');
    }
  }

  Future<void> refreshFavorites() async {
    try {
      var updatedFavorites = await _repository.getFavorites();
      favorites.assignAll(updatedFavorites);
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh favorites: $e');
    }
  }

  bool isFavorite(Product product) {
    return favorites.any((favorite) => favorite.id == product.id);
  }

  void toggleFavorite(Product product) async {
    bool isCurrentlyFavorited = isFavorite(product);
    if (isCurrentlyFavorited) {
      favorites.removeWhere((item) => item.id == product.id);
      bool success = await _repository.removeFavorite(product.id);
      if (!success) {
        favorites.add(product);
      }
    } else {
      favorites.add(product);
      bool success = await _repository.addFavorite(product.id);
      if (!success) {
        favorites.removeWhere((item) => item.id == product.id);
      }
    }
  }
}
