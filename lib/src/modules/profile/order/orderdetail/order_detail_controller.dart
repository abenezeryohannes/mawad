import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/orderItem.dart';
import 'package:mawad/src/data/repositories/order_repo.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/checkout/failed_transaction_screen.dart';
import 'package:mawad/src/modules/cart/checkout/success_transaction_screen.dart';

class OrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  final _newOrdersItem = <OrderItem>[].obs;
  final _oldOrdersItem = <OrderItem>[].obs;
  final orderDetail = Rxn<InvoiceOrder>();
  //CartController
  final CartController _cartController = Get.find<CartController>();

  final isLoadingNew = false.obs;
  final isLoadingOld = false.obs;
  final _selectedTab = 0.obs;

  List<OrderItem> get newOrdersItem => _newOrdersItem;
  List<OrderItem> get oldOrdersItem => _oldOrdersItem;

  //single order
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
    isLoadingNew.value = true;

    try {
      final result = await _orderRepo.getNewOrderItemList();
      isLoadingNew.value = false;
      _newOrdersItem.value = result;
      update(['newOrders']);
    } catch (error) {
      Get.snackbar('Error', 'Error fetching new orders');
    } finally {
      isLoadingNew.value = false;
    }
  }

//check the order status
  void checkOrderStatus(String id) async {
    try {
      final response = await _orderRepo.checkOrderStatus(id);
      if (AppConstants.FailedTransaction == response) {
        Get.to(const FailedTransactionScreen());
      }
      if (AppConstants.SuccessTransaction == response) {
        _cartController.clearCart();
        Get.to(SuccessTransactionScreen());
      }
    } catch (error) {
      log('Error fetching products checkOrderStatus: $error');
      rethrow;
    }
  }

  void getOldOrders() async {
    isLoadingOld.value = true;
    try {
      final result = await _orderRepo.getOldOrderItemList();
      _oldOrdersItem.value = result;
      isLoadingOld.value = false;
      update(['oldOrders']);
    } catch (error) {
      Get.snackbar('Error', 'Error fetching old orders');
    } finally {
      isLoadingOld.value = false;
    }
  }

  //get one order
  void getOrderItem(String id) async {
    isLoading.value = true;
    try {
      final result = await _orderRepo.getOrderItem(id);
      orderDetail.value = result;
      update(['orderDetail']);
    } catch (error) {
      Get.snackbar('Error', 'Error fetching order detail');
    } finally {
      isLoading.value = false;
    }
  }
}
