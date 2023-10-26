import 'package:get/get.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class MainController extends GetxController {
  final ProductController _productController = Get.put(ProductController());
}
