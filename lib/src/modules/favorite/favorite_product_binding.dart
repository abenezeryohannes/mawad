//binding

import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_binding.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class FavoriteProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(
      () => FavoritesController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut(() => RegisterWithPhoneBinding());
  }
}
