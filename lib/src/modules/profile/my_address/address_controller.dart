import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/data/repositories/profile_repo.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/main.page.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/profile/account_detail/profile.manager.page.dart';

class AddressController extends GetxController {
  final ProfileRepo _profileRepo = ProfileRepo();
  final ProductController productController = Get.find();
  final cities = <City>[].obs;
  final areas = <Area>[].obs;
  final locationDetails = <LocationDetail>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final selectedAreaId = ''.obs;
  final selectedCityId = ''.obs;
  final currentSelectedAddress = ''.obs;
  final isLeading = false.obs;
  Timer? _debounce;

  @override
  void onReady() {
    getCity(productController.selectedCountry.value?.id ?? '');

    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();

    getLocationDetail();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    disposeControllers();
    super.onClose();
  }

  void disposeControllers() {
    avenueController.dispose();
    houseController.dispose();
    blockController.dispose();
    floorController.dispose();
    streetController.dispose();
  }

  void reset() {
    currentSelectedAddress.value = '';
    avenueController.text = '';
    houseController.text = '';
    blockController.text = '';
    streetController.text = '';
    selectedCityId.value = '';
    selectedAreaId.value = '';
  }

  bool get isFormValid => formKey.currentState?.validate() ?? false;

  void setSelectedAddress(LocationDetail location) {
    currentSelectedAddress.value = location.id ?? '';
    avenueController.text = location.avenue ?? '';
    houseController.text = location.house ?? '';
    blockController.text = location.block ?? '';
    streetController.text = location.street ?? '';
    selectedCityId.value = location.city!.cityId ?? '';
    selectedAreaId.value = location.area!.areaId ?? '';
  }

  void onAreaOrCitySelected(String newValue, Function(String) setValue) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setValue(newValue);
    });
  }

  void onAreaSelected(String newAreaId) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      selectedAreaId.value = newAreaId;
    });
  }

  void onCitySelected(String newCityId) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      selectedCityId.value = newCityId;
      areas.value = []; // Clear existing areas
      getArea(newCityId);
    });
  }

  Future<void> getCity(String id) async {
    try {
      cities.value = await _profileRepo.getCity(id);

      selectedCityId.value = cities.first.cityId;
      log("cities.value${{cities}}");
      getArea(cities.first.cityId);
    } catch (error) {}
  }

  Future<void> getArea(String id) async {
    try {
      areas.value = await _profileRepo.getArea(id);
      selectedAreaId.value = areas.isNotEmpty ? areas.first.areaId : '';
    } catch (error) {
      log('Error getting areas: $error');
    }
  }

  Future<void> getLocationDetail() async {
    try {
      locationDetails.value = await _profileRepo.getLocationDetail();
    } catch (error) {}
  }

  void addLocationDetail(LocationDetail location, String type) async {
    final user = Get.find<RegisterWithPhoneController>();
    try {
      isLeading.value = true;
      final result = await _profileRepo.addLocationDetail(location);
      isLeading.value = false;
      if (user.userDetail.value!.name == "" &&
          user.userDetail.value!.userEmail == "") {
        getLocationDetail();
        reset();
        Get.to(const ProfileManagerPage());
      } else {
        if (type == AppConstants.PAGE_TYPE_PROFILE) {
          Get.to(const MainPage());
          return;
        } else {
          Get.back();
        }
      }
    } catch (error) {
      isLeading.value = false;
      print(error);
    }
  }

  Future<void> updateLocationDetail(LocationDetail location) async {
    try {
      isLeading.value = true;
      await _profileRepo.updateLocationDetail(location);

      getLocationDetail();
      Get.back();
      isLeading.value = false;
    } catch (error) {
      isLeading.value = false;
      log('Error updating location detail: $error');
    }
  }
}
