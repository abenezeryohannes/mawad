import 'dart:developer';
import 'dart:io';

import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/services/api_serives.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();
  final AuthTokenService _authTokenService = AuthTokenService();
  final LocalStorageService _localStorageService = LocalStorageService.instance;
  final FavoritesController favoritesController = FavoritesController();

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
      await _authTokenService.saveToken(accessToken);
      return accessToken;
    } catch (error) {
      rethrow;
    }
  }

  //get user detail
  Future<UserModel> getUserDetail() async {
    try {
      final result = await _apiService.getRequest('/user/me');

      final data = result['data'];
      if (data == null) {
        return UserModel.fromJson({});
      }
      UserModel user = UserModel.fromJson(result['data']);

      return user;
    } catch (error) {
      rethrow;
    }
  }

  //update account
  Future<bool> updateAccount(UserModel user) async {
    try {
      final result = await _apiService.postRequest(
          '/user/update-account', user.toJsonInput());
      log("updateAccount: $result");

      return result['success'];
    } catch (error) {
      log('Error fetching products updateAccount: $error');
      rethrow;
    }
  }

  Future<bool> isUserRegistered() async {
    return await _authTokenService.hasToken();
  }

  Future<String> addAvatar(File avatar) async {
    try {
      final result =
          await _apiService.uploadImage('/file/img/saveAttachments', avatar);
      String id = result['data'][0]['id'];

      return id;
    } catch (error) {
      rethrow;
    }
  }

  // delete account
  Future<bool> deleteAccount() async {
    try {
      final result = await _apiService.deleteAccountRequest('/user/delete');

      return result['success'];
    } catch (error) {
      log('Error fetching products deleteAccount: $error');
      rethrow;
    }
  }

  Future<bool> logout() async {
    final res = await deleteAccount();
    if (res) {
      await _authTokenService.logout();
      _localStorageService.delete(AppConstants.CART_ITEMS);
      _localStorageService.delete(AppConstants.ACCESS_TOKEN);
      favoritesController.favorites.value = [];
      return true;
    }
    return false;
  }
}
