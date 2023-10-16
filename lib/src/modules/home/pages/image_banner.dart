import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class ImageBanner extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onButtonPressed;

  const ImageBanner({
    super.key,
    required this.imagePath,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150,
              width: MediaQuery.of(context).size.width * (11 / 12),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: AppButton(
              radius: 20.r,
              height: 39.h,
              width: 130.w,
              text: "شاهد المزيد",
              textStyle: AppTextTheme.brown12,
              onPressed: () {
                Get.toNamed(AppRoutes.register);
              },
              color: AppColorTheme.white,
            ),
          ),
        ],
      ),
    );
  }
}
