import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/models/orderItem.dart';
import 'package:mawad/src/data/repositories/order_repo.dart';

class OrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  final _newOrdersItem = <OrderItem>[].obs;
  final _oldOrdersItem = <OrderItem>[].obs;
  final _selectedTab = 0.obs;

  List<OrderItem> get newOrdersItem => _newOrdersItem;
  List<OrderItem> get oldOrdersItem => _oldOrdersItem;
  final OrderRepo _orderRepo = OrderRepo();

  int get selectedTab => _selectedTab.value;
  set selectedTab(int value) => _selectedTab.value = value;

  @override
  void onInit() {
    super.onInit();
    getNewOrders();
    getOldOrders();
  }

  void getNewOrders() async {
    isLoading.value = true;

    try {
      final result = await _orderRepo.getNewOrderItemList();
      log("====>aaaa$result");
      _newOrdersItem.value = result;
      update(['newOrders']);
    } catch (error) {
      Get.snackbar('Error', 'Error fetching new orders');
    } finally {
      isLoading.value = false;
    }
  }

  void getOldOrders() async {
    isLoading.value = true;
    try {
      final result = await _orderRepo.getOldOrderItemList();
      _oldOrdersItem.value = result;
      update(['oldOrders']);
    } catch (error) {
      Get.snackbar('Error', 'Error fetching old orders');
    } finally {
      isLoading.value = false;
    }
  }
}
