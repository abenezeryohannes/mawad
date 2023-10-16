//binding

import 'package:get/get.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';

class FavoriteProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(
      () => FavoritesController(),
    );
  }
}
