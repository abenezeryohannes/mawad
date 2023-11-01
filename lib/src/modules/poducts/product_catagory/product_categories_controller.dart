import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/repositories/produact_category_repo.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class ProductCategoryController extends GetxController {
  final ProductCategoryRepo _productCategoryRepo = ProductCategoryRepo();
  final _selectedIndex = 0.obs;
  final _isSelected = false.obs;
  final searchController = TextEditingController();
  final _searchValue = ''.obs;

  String get searchValue => _searchValue.value;
  bool get isSelected => _isSelected.value;
  set isSelected(bool value) {
    _isSelected.value = value;
    update();
  }

  set searchValue(String value) {
    _searchValue.value = value;
    update();
  }

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) {
    _selectedIndex.value = index;
    update();
  }

  final RxString errorMessage = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  void fetchUser(String userId) async {
    try {
      final data = await _productCategoryRepo.fetchUserData(userId);
      log(data.toString());
    } catch (error) {
      log(error.toString());
      errorMessage.value = error.toString();
    }
  }

  void selectCategory(int index, String categoryId) {
    if (selectedIndex == index) return; // Avoid unnecessary updates
    selectedIndex = index;
    if (selectedIndex == 0) {
      Get.toNamed(AppRoutes.productCategory);
    } else {
      // _productController.getProductByCategory(categoryId);
    }
    update(); // This method is from GetX and it will update the UI
  }
}
