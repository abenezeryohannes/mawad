import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        haveTitle: true,
        title: 'Order Detail',
        showBackButton: true,
        body: Column(
          children: [
            buildDetail("قيمة الفاتورة", " KD 239.00"),
            buildDetail("قيمة الفاتورة", " KD 239.00"),
            buildDetail("قيمة الفاتورة", " salmanz@email.com", isBold: true),
          ],
        ));
  }

  Widget buildDetail(String title, String value, {bool isBold = false}) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(left: 20, right: 17.w),
      color: AppColorTheme.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: isBold
                      ? AppTextTheme.brown20
                      : AppTextTheme.graysubtitle12),
              Text(
                value,
                style:
                    isBold ? AppTextTheme.graysubtitle12 : AppTextTheme.brown20,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 1.h,
            color: AppColorTheme.darkWhite,
          )
        ],
      ),
    );
  }
}
