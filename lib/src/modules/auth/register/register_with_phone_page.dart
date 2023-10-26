import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/phone_input.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class RegisterWithPhonePage extends GetView<RegisterWithPhoneController> {
  const RegisterWithPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    'أدخل رقم الهاتف',
                    style: AppTextTheme.titleText26,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'سيتم إرسال لك رسالة قصيرة',
                    style: AppTextTheme.graysubtitle15,
                  ),
                  Text(
                    'بها رمز التفعيل علي الرقم المسجل',
                    style: AppTextTheme.graysubtitle15,
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
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
                          print(p0);

                          return p0;
                        },
                        hint: "XXXXXXXXXX",
                        inputColor: AppColorTheme.lightgray,
                        phoneNumberMaxLength: 10,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 153.h,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: AppButton(
                        radius: 0,
                        color: AppColorTheme.yellow,
                        text: 'إرسال',
                        onPressed: () {
                          Get.toNamed('/otp');
                          // if (formKey.currentState!.validate()) {
                          //   formKey.currentState!.save();
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
