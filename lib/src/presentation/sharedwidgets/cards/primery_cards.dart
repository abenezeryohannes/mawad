import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class PrimerCard extends StatelessWidget {
  final Widget child;
  final double height;
  const PrimerCard({required this.child, this.height = 65, super.key});

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
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: child,
    );
  }
}
