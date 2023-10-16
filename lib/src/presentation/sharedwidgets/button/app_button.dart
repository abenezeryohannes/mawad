import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final double radius;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.yellowAccent,
    this.textColor = Colors.white,
    this.textStyle,
    this.height,
    this.width,
    this.radius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 60.h,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: onPressed,
      color: color,
      textColor: textColor,
      child: Text(
        text,
        style: textStyle ?? AppTextTheme.dark18,
      ),
    );
  }
}
