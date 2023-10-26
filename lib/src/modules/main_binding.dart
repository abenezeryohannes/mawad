import 'package:get/get.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/main_controller.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
