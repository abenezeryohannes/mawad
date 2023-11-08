// create checklout repo

import 'dart:developer';

import 'package:mawad/src/core/models/payment_mode.dart';
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

  //getPaymentPercentage
}
