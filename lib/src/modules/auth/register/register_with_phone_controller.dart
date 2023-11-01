import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/data/repositories/auth_repo.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class RegisterWithPhoneController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();

  final isLoading = false.obs;
  final isOtpLoading = false.obs;
  final TextEditingController controller = TextEditingController();
  final OTP = 0.obs;

  final formKey = GlobalKey<FormState>();

  void registerWithPhone() async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final phone = controller.text;

        final user = await _authRepo.registerWithPhone(phone);
        if (user) {
          isLoading.value = false;
          Get.toNamed(AppRoutes.otp, arguments: phone);
        }
      }
    } catch (error) {
      isLoading.value = false;
      log(error.toString());
      // Handle error here
    }
  }

  void validateOTP(phone) async {
    try {
      isOtpLoading.value = true;
      if (OTP.value.toString().length == 4) {
        final result = await _authRepo.validateOTP(phone, OTP.value.toString());

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

  Future<bool> isAuth() async {
    return _authRepo.isUserRegistered();
  }
}
