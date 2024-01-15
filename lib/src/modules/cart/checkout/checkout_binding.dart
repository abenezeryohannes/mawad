import 'package:get/get.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_controller.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => AddressController());
  }
}
