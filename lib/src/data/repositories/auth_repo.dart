import 'dart:developer';

import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/services/api_serives.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();
  final AuthTokenService _authTokenService = AuthTokenService();

  Future<bool> registerWithPhone(String phone) async {
    const String recaptchaToken =
        '03AFcWeA4wrQKKoJMB4Lng7tZgkKj365xqNUkRYMzyFVZqHHHV-UbDRjmgwriM3Fe0p3lmAjhwMuS074DPTber3Y5rqpraYU2MC6FB1iLBKV_jaA5Z3xBtkyHKeef7FJ4VjTtPDzve68QAIh_YD3bk3IbZiE8KXDznL3KNBuPVsN1EMfSonIyQvAn14YAUwrcQVjBTmDsT8UdrBFf9D9qaUCO390JVA6rCQQSYFpnHH9e6SiNaJ3gauNPsI1VD0sXM-AfChSBrViQYAgajm_4nH4VOlcCH73scD1sSeB7RYxwtdZ4Sa48R3VZ4LtQmXchlQu7d_kk1fiWCfTb2XsuZGzdLABEM2LYUrHCd0GFUTmqbIQxO9oBqbxvmuNmg9GrMrwr_oAad7KxFEFYtsahLw4HtzScj3DX0aQoOkFfcLiFS52xGcrMRzxYD0kT6tRmX57yWmIyB5Nl5XubpvtybcZP8cqMiyHbYWd8dhbwZVQbQjVmDWRHSWHxZLRxqvCD_STTS7nDu7RTD81b3ZatxhUTi5n5ggUWWVQ';

    try {
      final result = await _apiService.postRequest('/auth/send-code',
          {"recaptchaToken": recaptchaToken, "phone": phone});

      if (result['success']) {
        if (result.containsKey('accessToken')) {
          await _authTokenService.saveToken(result['accessToken']);
        }
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> validateOTP(String phone, String otp) async {
    try {
      final result = await _apiService.postRequest('/auth/check-code', {
        "phone": phone,
        "code": otp,
      });

      String accessToken = result['data']['accessToken'];
      log("accessToken: $accessToken");
      await _authTokenService.saveToken(accessToken);
      return accessToken;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> addAccountDetail(UserModel user) async {
    try {
      final result =
          await _apiService.postRequest('user/update-account', user.toJson());

      return UserModel.fromJson(result['data']);
    } catch (error) {
      rethrow;
    }
  }

  //get user detail
  Future<UserModel> getUserDetail() async {
    try {
      final result = await _apiService.getRequest('/user/me');

      if (result['success'] && result['data'] != null) {
        return UserModel.fromJson(result['data']);
      }
      return UserModel(
        phone: '',
      );
    } catch (error) {
      log('Error fetching products getUserDetail: $error');

      rethrow;
    }
  }

  Future<bool> isUserRegistered() async {
    return await _authTokenService.hasToken();
  }
}
