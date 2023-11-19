import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/repositories/auth_repo.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class RegisterWithPhoneController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  final userDetail = Rx<UserModel?>(null);

  final isLoading = false.obs;
  final isOtpLoading = false.obs;
  final TextEditingController controller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final OTP = 0.obs;

  final formKey = GlobalKey<FormState>();

  //int

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    isLoading.value = false;
  }

  void registerWithPhone() async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final phone = controller.text;

        final user = await _authRepo
            .registerWithPhone(convertToInternationalPhoneNumber(phone));
        if (user) {
          isLoading.value = false;
          Get.toNamed(AppRoutes.otp,
              arguments: convertToInternationalPhoneNumber(phone));
        }
      }
    } catch (error) {
      isLoading.value = false;
      log(error.toString());
      // Handle error here
    }
  }

  bool isPhoneNumberValid(String phoneNumber) {
    final RegExp phoneRegExp =
        RegExp(r'^(?:\+?\d{1,3})?\s?-?\(?\d{3}\)?\s?-?\d{3}\s?-?\d{4}$');

    return phoneRegExp.hasMatch(phoneNumber);
  }

  String convertToInternationalPhoneNumber(String phoneNumber,
      [String countryCode = '251']) {
    String numericOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.length == 10 && numericOnly.startsWith('0')) {
      numericOnly = numericOnly.substring(1);
    }

    if (!numericOnly.startsWith('251')) {
      return '$countryCode$numericOnly';
    }
    return numericOnly;
  }

  void validateOTP(phone) async {
    log("validateOTP:  ${convertToInternationalPhoneNumber(phone)}");
    try {
      isOtpLoading.value = true;
      if (OTP.value.toString().length == 4) {
        final result = await _authRepo.validateOTP(
            convertToInternationalPhoneNumber(phone), OTP.value.toString());

        if (result.isNotEmpty) {
          isOtpLoading.value = false;

          Get.offAllNamed(AppRoutes.main);
        }
      }
    } catch (error) {
      isOtpLoading.value = false;
      log(error.toString());
      // Handle error here
    }
  }

  void getUserDetail() async {
    final user = await _authRepo.getUserDetail();

    userDetail.value = user;
  }

  void updateUserDetail(UserModel user) async {
    log("updateUserDetail:  ${user.toJson()}");
    try {
      isLoading.value = true;
      await _authRepo.updateAccount(user);
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      log(error.toString());
      // Handle error here
    }
  }

  Future<bool> isAuth() async {
    return _authRepo.isUserRegistered();
  }

  void logout() async {
    await _authRepo.logout();
    update();
    Get.close(2);
  }
}
