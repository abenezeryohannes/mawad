import 'package:get/get.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
