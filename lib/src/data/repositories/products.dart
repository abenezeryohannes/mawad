import 'dart:developer';

import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/core/models/image_model.dart';
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
      log('Error fetching products getCountries: $error');
      rethrow;
    }
  }

  List<Country> mapDataToCountries(List<dynamic> data) {
    return data.map((json) => Country.fromJson(json)).toList();
  }

  Future<List<Product>> getProductByCountry(String id) async {
    try {
      final result = await _apiService.getRequest('/website/home-products/$id');

      List<Product> products = mapDataToProducts(result['data']['content']);
      log(products.toString());
      return products;
    } catch (error) {
      log('Error fetching products getProductByCountry: $error');
      rethrow;
    }
  }

  Future<List<Product>> getProductByCategory(String id) async {
    try {
      final result =
          await _apiService.getRequest('/product/by_category_id/$id');
      log(result["data"]["content"].toString());
      List<Product> products = mapDataToProducts(result['data']["content"]);
      log(products.toString());
      return products;
    } catch (error) {
      log('Error fetching products getProductByCategory: $error');
      rethrow;
    }
  }

  Future<List<ImageModel>> getBanner() async {
    try {
      final result = await _apiService.getRequest('/big-banner/website');
      log(result.toString());
      List<ImageModel> banners = mapBanner(result['data']);
      log(banners.toString());
      return banners;
    } catch (error) {
      log('Error fetching products getBanner: $error');
      rethrow;
    }
  }

  List<ImageModel> mapBanner(List<dynamic> data) {
    return data.map((json) => ImageModel.fromJson(json)).toList();
  }

  List<Product> mapDataToProducts(List<dynamic> data) {
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductDetail(String id) async {
    try {
      final result = await _apiService.getRequest('/product/$id');

      Product products = mapDataToProductDetail(result['data']);
      if (products.productAddons.isNotEmpty) {
        log("product===> ${products.productAddons.first.addonOption}");
      } else {
        log("productAddons is empty.");
      }

      return products;
    } catch (error) {
      log('Error fetching products mapDataToProducts:  $error');
      rethrow;
    }
  }

  Product mapDataToProductDetail(Map<String, dynamic> data) {
    return Product.fromJson(data);
  }
}
