import 'package:get/get.dart';
import 'package:mawad/src/modules/cart/carts/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}
