import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class PrimerCard extends StatelessWidget {
  final Widget child;
  final double height;
  final double radius;
  final bool hasBorder;
  final Color? borderColor;
  const PrimerCard(
      {this.radius = 6,
      this.hasBorder = false,
      this.borderColor,
      required this.child,
      this.height = 65,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      height: height.h,
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
      decoration: BoxDecoration(
        color: AppColorTheme.white,
        borderRadius: BorderRadius.circular(radius.r),
        border: hasBorder
            ? Border.all(
                color: borderColor ?? AppColorTheme.yellow,
                width: 3.sp,
                style: BorderStyle.solid,
                strokeAlign: 2)
            : const Border.fromBorderSide(BorderSide.none),
      ),
      child: child,
    );
  }
}
