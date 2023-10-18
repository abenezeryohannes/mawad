import 'dart:developer';

import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class ProductsRepo {
  final ApiService _apiService = ApiService();

  Future<List<Country>> getCountries() async {
    try {
      final result = await _apiService.getRequest('/website/countries');
      List<Country> countries = mapDataToCountries(result['data']);
      return countries;
    } catch (error) {
      rethrow;
    }
  }

  List<Country> mapDataToCountries(List<dynamic> data) {
    return data.map((json) => Country.fromJson(json)).toList();
  }

  Future<List<Product>> getProductByCountry(String id) async {
    try {
      final result = await _apiService.getRequest('/website/home-products/$id');

      List<Product> products = mapDataToProducts(result['data']);
      log(products.toString());
      return products;
    } catch (error) {
      log('Error fetching products: $error');
      rethrow;
    }
  }

  List<Product> mapDataToProducts(List<dynamic> data) {
    return data.map((json) => Product.fromJson(json)).toList();
  }
}
