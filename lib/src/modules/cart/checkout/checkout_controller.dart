import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/models/payment_mode.dart';
import 'package:mawad/src/core/models/payment_type.dart';
import 'package:mawad/src/data/repositories/checkout_repo.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class CheckoutController extends GetxController {
  final CheckoutRepo _checkoutRepo = CheckoutRepo();
  final paymentPercentageItems = RxList<PaymentPercentage>([]);

  @override
  void onInit() {
    super.onInit();
    getPaymentPercentage();
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

  final paymentType = <PaymentTypeMode>[
    PaymentTypeMode(id: "1", name: "Knet", icon: IconRoutes.kent),
    PaymentTypeMode(id: "2", name: "Card", icon: IconRoutes.visa),
    PaymentTypeMode(id: "3", name: "Cash", icon: IconRoutes.cash),
  ].obs;
}
