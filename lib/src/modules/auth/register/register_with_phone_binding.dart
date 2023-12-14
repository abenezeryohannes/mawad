import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/profile/my_address/address_controller.dart';

class RegisterWithPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => RegisterWithPhoneController(), permanent: true);
    Get.lazyPut(() => AddressController());
  }
}
