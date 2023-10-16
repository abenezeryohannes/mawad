import 'package:get/get.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
