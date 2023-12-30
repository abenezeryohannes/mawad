import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/otp_input.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class OtpPage extends GetView<RegisterWithPhoneController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return MainScaffold(
        backgroundColor: AppColorTheme.white,
        showBackButton: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Enter activation code".tr,
                  style: AppTextTheme.brown25,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter the sent code".tr,
                  style: AppTextTheme.graysubtitle15,
                ),
                Text(
                  "${"On number".tr} $argument",
                  style: AppTextTheme.graysubtitle15,
                ),
                SizedBox(
                  height: 50.h,
                ),
                OtpInput(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid code';
                    }
                    return null;
                  },
                  onCompleted: (value) {
                    controller.OTP.value = int.parse(value);
                    if (value.length == 4) {
                      controller.validateOTP(argument);
                    }
                  },
                ),
                SizedBox(
                  height: 61.h,
                ),
                Obx(() {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: controller.timer <= 0
                        ? Column(
                            children: [
                              Text(
                                "Activation code did not arrive?".tr,
                                style: AppTextTheme.lightGray17,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.registerWithPhone();
                                  },
                                  child: Text(
                                    "Click to resend.".tr,
                                    style: AppTextTheme.yellow14,
                                  )),
                            ],
                          )
                        : Container(
                            child: Text(
                              "${"Resend code in".tr} ${controller.timer}"
                                      "seconds"
                                  .tr,
                              style: AppTextTheme.lightGray17,
                            ),
                          ),
                  );
                }),
              ],
            ),
            SizedBox(
                width: isKeyboardOpen ? Get.width : Get.width * 0.9,
                child: Obx(() {
                  return BigTextButton(
                    isLoading: controller.isOtpLoading.value,
                    text: 'Confirm'.tr,
                    fontSize: 18,
                    fontWight: FontWeight.bold,
                    cornerRadius: isKeyboardOpen ? 0.r : 22.r,
                    elevation: 0,
                    backgroudColor: AppColorTheme.yellow,
                    borderColor: AppColorTheme.yellow,
                    textColor: AppColorTheme.brown,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                    ),
                    onClick: () {
                      if (controller.OTP.value < 3) {
                        return;
                      }
                      controller.validateOTP(argument);
                    },
                  );
                }))
          ],
        ));
  }
}
