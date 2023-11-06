import 'dart:developer';

import 'package:mawad/src/core/models/catagorie.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class ProductCategoryRepo {
  final ApiService _apiService = ApiService();

  Future<List<CategoryModel>> getCategory(String id) async {
    try {
      final result = await _apiService.getRequest('/website/category/$id');
      List<CategoryModel> category = mapDataToCategory(result['data']);

      return category;
    } catch (error) {
      log('Error fetching products: $error');
      rethrow;
    }
  }

  List<CategoryModel> mapDataToCategory(List<dynamic> data) {
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
