import 'package:get/get.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/main_controller.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthTokenService>(AuthTokenService());

    Get.lazyPut<FavoritesController>(() => FavoritesController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ProductController>(() => ProductController());

    Get.put(RegisterWithPhoneController());
  }
}
