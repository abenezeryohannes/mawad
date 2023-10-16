import 'dart:developer';

import 'package:mawad/src/data/services/api_serives.dart';

class ProductCategoryRepo {
  final ApiService _apiService = ApiService();

  Future<Map> fetchUserData(String phone) async {
    log("phone: $phone");
    try {
      final result = await _apiService.postRequest('/auth/send-code', {
        "recaptchaToken": "6Le73mIgAAAAAHAcNOnzqRHPsQVnS-EiTjG7KYQW",
        "phone": phone
      });
      log("after: $phone");
      log(result.toString());
      return result;
    } catch (error) {
      rethrow;
    }
  }
}
