import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void selectCategory(int index, String categoryId) {
    if (selectedIndex == index) return; // Avoid unnecessary updates
    selectedIndex = index;
    if (selectedIndex == 0) {
      Get.toNamed(AppRoutes.productCategory);
    } else {}
    update(); // This method is from GetX and it will update the UI
  }
}
