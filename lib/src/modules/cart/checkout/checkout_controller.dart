import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/enums/paymentType.dart';
import 'package:mawad/src/core/models/order.dart';
import 'package:mawad/src/core/models/payment_mode.dart';
import 'package:mawad/src/core/models/payment_type.dart';
import 'package:mawad/src/data/repositories/checkout_repo.dart';
import 'package:mawad/src/modules/cart/payment/payment_view.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutController extends GetxController {
  final CheckoutRepo _checkoutRepo = CheckoutRepo();
  final paymentPercentageItems = RxList<PaymentPercentage>([]);
  late WebViewController controller;
  var paymentAvailability = Rxn<PaymentMethods>();
  var selectedPaymentTypeId = PaymentType.values[0].obs;
  final _downPayment = 0.0.obs;
  final isLoading = false.obs;

  double get downPayment => _downPayment.value;
  set downPayment(double value) => _downPayment.value = value;

  void setSelectedPaymentType(PaymentType id) {
    selectedPaymentTypeId.value = id;
  }

  @override
  void onInit() {
    super.onInit();
    getPaymentPercentage();
    getPaymentAvailability();
    getOrderList();
  }

  void getPaymentPercentage() async {
    try {
      final result = await _checkoutRepo.getPaymentPercentage();
      log('getPaymentPercentage==>: $result');
      paymentPercentageItems.value = result;
    } catch (error) {
      rethrow;
    }
  }

  void getOrderList() async {
    try {
      final result = await _checkoutRepo.getOrderList();
      log('getOrderList==>: $result');
    } catch (error) {
      rethrow;
    }
  }

// make order
  Future<void> makeOrder(OrderModel order) async {
    try {
      isLoading.value = true;
      final result = await _checkoutRepo.makeOrder(order);
      isLoading.value = false;
      Get.to(() => PaymentWebViewScreen(paymentUrl: result.payLink));
    } catch (error) {
      log("makeOrder error $error");
      isLoading.value = false;
      rethrow;
    }
  }

  void getPaymentAvailability() async {
    try {
      final result = await _checkoutRepo.getPaymentAvailability();
      log('getPaymentAvailability==>: $result');
      paymentAvailability.value = result;

      updatePaymentAvailability(result);
    } catch (error) {
      rethrow;
    }
  }

  final paymentType = <PaymentTypeMode>[
    PaymentTypeMode(id: "1", name: PaymentType.Knet, icon: IconRoutes.kent),
    PaymentTypeMode(id: "2", name: PaymentType.Card, icon: IconRoutes.visa),
    PaymentTypeMode(id: "3", name: PaymentType.Cash, icon: IconRoutes.cash),
  ].obs;

  void updatePaymentAvailability(PaymentMethods paymentOptions) {
    paymentType[0].isAvailable = paymentOptions.knet;
    paymentType[1].isAvailable = paymentOptions.card;
    paymentType[2].isAvailable = paymentOptions.cash;
    update(); // Notify listeners to update UI
  }
}
