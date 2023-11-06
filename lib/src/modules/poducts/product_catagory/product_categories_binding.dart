import 'package:get/get.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_controller.dart';

class ProductCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductCategoryController>(
      () => ProductCategoryController(),
    );
    Get.put<FavoritesController>(
      FavoritesController(),
    );
  }
}
