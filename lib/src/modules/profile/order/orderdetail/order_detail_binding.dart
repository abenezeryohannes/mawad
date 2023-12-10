import 'package:get/get.dart';
import 'package:mawad/src/modules/profile/order/orderdetail/order_detail_controller.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
  }
}
