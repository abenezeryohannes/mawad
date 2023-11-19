import 'dart:developer';

import 'package:mawad/src/core/models/order.dart';
import 'package:mawad/src/core/models/payment_mode.dart';
import 'package:mawad/src/core/models/payment_type.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class CheckoutRepo {
//_apiService
  final ApiService _apiService = ApiService();

  Future<List<PaymentPercentage>> getPaymentPercentage() async {
    try {
      final result = await _apiService.getRequest('/payment-percentage');
      log('getPaymentPercentage==|||>: $result');
      return mapPaymentMode(result['data']);
    } catch (error) {
      rethrow;
    }
  }

  List<PaymentPercentage> mapPaymentMode(List<dynamic> data) {
    return data.map((json) => PaymentPercentage.fromJson(json)).toList();
  }

// make order
  Future<PaymentInfo> makeOrder(OrderModel order) async {
    try {
      log('makeOrder==>: ${order.toMap()}');
      final result = await _apiService.postRequest(
          '/website/order/make-order', order.toMap());
      log('makeOrder==|||>: $result');
      return PaymentInfo.fromJson(result['data']);
    } catch (error) {
      log("makeOrder error $error");
      rethrow;
    }
  }

  Future<PaymentMethods> getPaymentAvailability() async {
    try {
      final result = await _apiService.getRequest('/website/payment/type');
      log('getPaymentAvailability==|||>: $result');
      return PaymentMethods.fromJson(result['data']);
    } catch (error) {
      rethrow;
    }
  }
}
