import 'dart:developer';

import 'package:mawad/src/core/models/orderItem.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class OrderRepo {
  final ApiService _apiService = ApiService();

  Future<List<OrderItem>> getNewOrderItemList() async {
    try {
      final result = await _apiService.getRequest('/order/getNewOrder');

      List<OrderItem> orders = mapDataToOrderDetail(result['data']);

      return orders;
    } catch (error) {
      log('Error fetching products getNewOrderItemList: $error');
      rethrow;
    }
  }

  Future<List<OrderItem>> getOldOrderItemList() async {
    try {
      final result = await _apiService.getRequest('/order/getOldOrder');
      List<OrderItem> orders = mapDataToOrderDetail(result['data']);
      return orders;
    } catch (error) {
      log('Error fetching products getOldOrderItemList: $error');
      rethrow;
    }
  }

  List<OrderItem> mapDataToOrderDetail(List<dynamic> data) {
    return data.map((json) => OrderItem.fromJson(json)).toList();
  }

  Future<OrderDetail> getOrderItem(String id) async {
    try {
      final response = await _apiService.getRequest('/order/getOne/$id');

      final orderDetail = OrderDetail.fromJson(response["data"]);
      return orderDetail;
    } catch (error) {
      log('Error fetching products getOrderItem: $error');
      rethrow;
    }
  }

  //cehck the order status
  Future<String> checkOrderStatus(String id) async {
    log("response= ==trak=> $id");
    try {
      final response = await _apiService
          .postRequest('/check-payment-status?trackId=$id', {});

      final orderDetail = response["data"]["transaction"]['result'];
      log("response==========????????---<< $orderDetail");
      return orderDetail;
    } catch (error) {
      log('Error fetching products checkOrderStatus: $error');
      rethrow;
    }
  }
}
