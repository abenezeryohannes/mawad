import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class FailedTransactionScreen extends StatelessWidget {
  const FailedTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/svg/failed.svg'),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Payment Failed!".tr,
            style: AppTextTheme.brown28,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Please try again".tr,
            style: AppTextTheme.brown20,
          ),
          SizedBox(
            height: 100.h,
          ),
          AppButton(
            text: "BACK".tr,
            onPressed: () {
              Get.close(2);
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
