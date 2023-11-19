import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/data/repositories/profile_repo.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

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
  void onInit() {
    super.onInit();
    getCity(productController.selectedCountry.value?.id ?? '');
    getLocationDetail();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    avenueController.dispose();
    houseController.dispose();
    blockController.dispose();
    floorController.dispose();
    streetController.dispose();
    super.onClose();
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

  void onAreaSelected(String newAreaId) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      selectedAreaId.value = newAreaId;
    });
  }

  void onCitySelected(String newCityId) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      selectedCityId.value = newCityId;
      getArea(newCityId);
    });
  }

  Future<void> getCity(String id) async {
    try {
      cities.value = await _profileRepo.getCity(id);
      if (cities.isNotEmpty) {
        selectedCityId.value = cities.first.cityId;
        getArea(cities.first.cityId);
      }
    } catch (error) {
      log('Error getting cities: $error');
    }
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
      log("getLocationDetail: ${locationDetails.toList().toString()}");
    } catch (error) {
      log('Error getting location details: $error');
    }
  }

  void addLocationDetail(LocationDetail location) async {
    try {
      final result = await _profileRepo.addLocationDetail(location);
      if (result) {
        getLocationDetail();
        Get.back();
      }
    } catch (error) {
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
