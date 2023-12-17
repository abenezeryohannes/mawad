import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class InputAddonHandler extends GetView<ProductController> {
  const InputAddonHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimerCard(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "Do you have special specifications?",
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller: controller
                .commentController, // You need to create a TextEditingController
            hintText: '',
            onChanged: (text) {},
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "Special request will be answered within two business days",
              style: AppTextTheme.graysubtitle12,
            ),
          ),
        ],
      ),
    );
  }
}
