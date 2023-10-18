import 'package:mawad/src/core/models/products.dart';
import 'dart:convert';

import 'package:mawad/src/data/services/localstorage_service.dart';

class FavoritesService {
  static const _key = 'favorite_products';
  final LocalStorageService _localStorage = LocalStorageService();

  Future<void> addFavorite(Product product) async {
    final currentFavs = await getFavorites();
    currentFavs.add(product);
    final encodedData = jsonEncode(currentFavs.map((e) => e.toMap()).toList());
    await _localStorage.saveString(_key, encodedData);
  }

  Future<void> removeFavorite(Product product) async {
    final currentFavs = await getFavorites();
    currentFavs.remove(product);
    final encodedData = jsonEncode(currentFavs.map((e) => e.toMap()).toList());
    await _localStorage.saveString(_key, encodedData);
  }

  Future<List<Product>> getFavorites() async {
    final encodedData = _localStorage.getString(_key) ?? '[]';
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((data) => Product.fromJson(data)).toList();
  }
}
