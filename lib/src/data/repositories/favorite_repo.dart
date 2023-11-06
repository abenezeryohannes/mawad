import 'dart:developer';

import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/api_serives.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';

class FavoritesRepository {
  final ApiService _apiService = ApiService();
  final AuthTokenService _authTokenService = AuthTokenService();

  Future<List<Product>> getFavorites() async {
    try {
      final result = await _apiService.getRequest('/user/favourites');
      log(result["data"]["content"].toString());
      List<Product> products = mapDataToProducts(result['data']["content"]);
      log(products.toString());
      return products;
    } catch (error) {
      _authTokenService.logout();
      log('Error fetching products getFavorites: $error');
      rethrow;
    }
  }

  List<Product> mapDataToProducts(List<dynamic> data) {
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<bool> addFavorite(String productId) async {
    try {
      final result =
          await _apiService.postRequest('/user/favourites/$productId', {});

      return result['success'];
    } catch (e) {
      // Log the error
      print('Failed to add favorite: $e');
      return false;
    }
  }

  Future<bool> removeFavorite(String productId) async {
    try {
      final result =
          await _apiService.deleteRequest('/user/favourites/$productId');
      log(result.toString());
      return result['success'];
    } catch (e) {
      // Log the error
      print('Failed to remove favorite: $e');
      return false;
    }
  }
}
