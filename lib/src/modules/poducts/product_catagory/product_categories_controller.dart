import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/data/repositories/produact_category_repo.dart';

class ProductCategoryController extends GetxController {
  final ProductCategoryRepo _productCategoryRepo = ProductCategoryRepo();
  final _selectedIndex = 0.obs;
  final searchController = TextEditingController();
  final _searchValue = ''.obs;

  String get searchValue => _searchValue.value;
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
}
