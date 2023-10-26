import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/otp_input.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: AppColorTheme.white,
        showBackButton: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "أدخل رمز التفعيل",
                  style: AppTextTheme.brown25,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter the sent code",
                  style: AppTextTheme.graysubtitle15,
                ),
                Text(
                  "On number 98998999",
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
                    print('Your input is $value.');
                  },
                ),
                SizedBox(
                  height: 61.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      Text(
                        "Activation code did not arrive?",
                        style: AppTextTheme.lightGray17,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Click to resend.",
                            style: AppTextTheme.yellow14,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width,
              child: AppButton(
                radius: 0,
                text: "Submit",
                onPressed: () {},
                color: AppColorTheme.yellow,
              ),
            )
          ],
        ));
  }
}
