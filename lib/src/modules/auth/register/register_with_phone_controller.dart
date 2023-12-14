import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/repositories/auth_repo.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/profile/account_detail/profile.manager.page.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

import '../../../presentation/sharedwidgets/custome_snack.dart';

class RegisterWithPhoneController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  final userDetail = Rx<UserModel?>(null);

  final _error = ''.obs;

  final AddressController addressController = Get.put(AddressController());
  final ProductController productController = Get.find<ProductController>();

  final isLoading = false.obs;
  final isOtpLoading = false.obs;

  String get errorMessage => _error.value;
  set errorMessage(String value) => _error.value = value;

  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final OTP = 0.obs;

  final formKey = GlobalKey<FormState>();
  final formKeyA = GlobalKey<FormState>();

  //int

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserDetail();
  }

  @override
  void onInit() {
    super.onInit();

    isLoading.value = false;
  }

  void registerWithPhone() async {
    try {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final phone = phonecontroller.text;

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
    final RegExp phoneRegExp = RegExp(r'^(?:\+965\s?)?\d{8}$');

    return phoneRegExp.hasMatch(phoneNumber);
  }

  String convertToInternationalPhoneNumber(String phoneNumber,
      [String defaultCountryCode = '965']) {
    String numericOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.startsWith('965')) {
      return numericOnly;
    }

    if (numericOnly.length == 8) {
      return '$defaultCountryCode$numericOnly';
    }

    if (numericOnly.startsWith('0')) {
      numericOnly = numericOnly.substring(1);
    }

    return '$defaultCountryCode$numericOnly';
  }

  void validateOTP(phone) async {
    try {
      isOtpLoading.value = true;
      if (OTP.value.toString().length == 4) {
        final result = await _authRepo.validateOTP(
            convertToInternationalPhoneNumber(phone), OTP.value.toString());
        final userd = await getUserDetail();

        log("userDetail.value${userDetail.value?.toJsonInput()}");

        isOtpLoading.value = false;
        if (userd.name != "" && userd.userEmail != "" && userd.phone != "") {
          Get.toNamed(AppRoutes.main);
        } else {
          showCustomSnackbar(
              title: "Data is Incomplete",
              message: "Complete your detail to place order");
          Get.offAll(const ProfileManagerPage());
        }
      }
    } catch (error) {
      isOtpLoading.value = false;
      log(error.toString());
      showCustomSnackbar(title: "", message: "Wrong OTP");
      // Handle error here
    }
  }

  Future<UserModel> getUserDetail() async {
    final user = await _authRepo.getUserDetail();
    update();
    userDetail.value = user;

    nameController.text = user.name ?? '';
    emailController.text = user.userEmail ?? '';
    phonecontroller.text = user.phone ?? '';

    return user;
  }

  void updateUserDetail(UserModel user) async {
    try {
      isLoading.value = true;
      await _authRepo.updateAccount(user);
      isLoading.value = false;
      getUserDetail();

      if (addressController.locationDetails.isEmpty) {
        Get.toNamed(AppRoutes.addAddress,
            arguments: AppConstants.PAGE_TYPE_PROFILE);
        addressController
            .getCity(productController.selectedCountry.value?.id ?? '');
      } else {
        Get.back();
      }
    } catch (error) {
      showCustomSnackbar(
        title: 'Error',
        message: 'Please add valid data',
      );
      isLoading.value = false;

      // Handle error here
    }
  }

  Future<bool> isAuth() async {
    getUserDetail();
    return _authRepo.isUserRegistered();
  }

// add avatar
  Future<void> addAvatar(File path) async {
    try {
      String result = await _authRepo.addAvatar(path);
      log("userDetail=>$result");
      var x = await _authRepo.updateAccount(
        UserModel(
            phone: userDetail.value?.phone,
            name: userDetail.value?.name,
            userEmail: userDetail.value?.userEmail,
            fileId: result),
      );
      getUserDetail();
    } catch (error) {
      log(error.toString());
    }
  }

  void logout() async {
    await _authRepo.logout();
    //clear all cash and refresh the app
    userDetail.value = null;
    addressController.reset();
    // locationDetails
    addressController.locationDetails.value = [];

    update();
    Get.toNamed(AppRoutes.main);
  }
}
