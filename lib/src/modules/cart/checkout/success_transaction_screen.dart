import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/home/pages/home.page.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SuccessTransactionScreen extends StatelessWidget {
  SuccessTransactionScreen({super.key});
  final RegisterWithPhoneController controller =
      Get.put(RegisterWithPhoneController());

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/svg/success.svg'),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Payment successful!".tr,
            style: AppTextTheme.brown28,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "${"The order  confirmation has been sent to".tr} ${controller.userDetail.value?.userEmail}",
            style: AppTextTheme.brown20,
          ),
          SizedBox(
            height: 100.h,
          ),
          AppButton(
            text: "Go To order".tr.toUpperCase(),
            onPressed: () {
              Get.to(const HomePage());
            },
            width: Get.width * 0.8,
            radius: 20.r,
            color: AppColorTheme.yellow,
          )
        ],
      ),
    );
  }
}
