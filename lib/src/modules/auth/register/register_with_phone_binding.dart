import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';

class RegisterWithPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterWithPhoneController());
  }
}
