import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/phone_input.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class RegisterWithPhonePage extends GetView<RegisterWithPhoneController> {
  const RegisterWithPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return MainScaffold(
        backgroundColor: AppColorTheme.white,
        showBackButton: true,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Enter a phone number',
                    style: AppTextTheme.titleText26,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'A short message will be sent to you',
                    style: AppTextTheme.graysubtitle15,
                  ),
                  Text(
                    'to confirm your phone number',
                    style: AppTextTheme.graysubtitle15,
                  ),
                ],
              ),
            ),
            Form(
              key: controller.formKey,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          vertical: 57.38.h, horizontal: 33.12.w),
                      child: CustomPhoneInput(
                        onChanged: (p0) {
                          controller.controller.text = p0;

                          return p0;
                        },
                        hint: "XXXXXXXXXX",
                        inputColor: AppColorTheme.lightgray,
                        phoneNumberMaxLength: 8,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter phone number';
                          }
                          if (!controller.isPhoneNumberValid(val)) {
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    SizedBox(
                        width: isKeyboardOpen ? Get.width : Get.width * 0.9,
                        child: SizedBox(child: Obx(() {
                          return BigTextButton(
                            isLoading: controller.isLoading.value,
                            text: 'Continue',
                            fontWight: FontWeight.bold,
                            cornerRadius: isKeyboardOpen ? 0.r : 22.r,
                            elevation: 0,
                            backgroudColor: AppColorTheme.yellow,
                            borderColor: AppColorTheme.yellow,
                            textColor: AppColorTheme.brown,
                            padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                            onClick: () {
                              if (controller.formKey.currentState!.validate() &&
                                  controller.controller.text.isNotEmpty &&
                                  controller.isPhoneNumberValid(
                                      controller.controller.text)) {
                                controller.registerWithPhone();
                              }
                            },
                          );
                        }))),
                    SizedBox(
                      height: 0.1.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
