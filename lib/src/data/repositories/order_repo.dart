import 'dart:developer';

import 'package:mawad/src/core/models/orderItem.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class OrderRepo {
  final ApiService _apiService = ApiService();

  Future<List<OrderItem>> getNewOrderItemList() async {
    try {
      final result = await _apiService.getRequest('/order/getNewOrder');

      var x = result['data'];
      List<OrderItem> countries =
          x.map((json) => OrderItem.fromJson(json)).toList();
      return countries;
    } catch (error) {
      log('Error fetching products getNewOrderItemList: $error');
      rethrow;
    }
  }

  Future<List<OrderItem>> getOldOrderItemList() async {
    try {
      final result = await _apiService.getRequest('/order/getOldOrder');
      List<OrderItem> countries = mapDataToOrderDetail(result['data']);
      return countries;
    } catch (error) {
      log('Error fetching products getOldOrderItemList: $error');
      rethrow;
    }
  }

  List<OrderItem> mapDataToOrderDetail(List<dynamic> data) {
    return data.map((json) => OrderItem.fromJson(json)).toList();
  }
}
