import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class TextAreaFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final void Function(String)? onChanged;

  const TextAreaFiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 3,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.start,
      onChanged: onChanged,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorTheme.lightGray, // Light gray border color
          ),
          borderRadius: BorderRadius.circular(15.r), // Border radius
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorTheme.lightGray, // Light gray border color
          ),
          borderRadius: BorderRadius.circular(15.r), // Border radius
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorTheme.lightGray, // Light gray border color
          ),
          borderRadius: BorderRadius.circular(15.r), // Border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorTheme.lightGray, // Light gray border color
          ),
          borderRadius: BorderRadius.circular(15.r), // Border radius
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 4), // Padding
      ),
    );
  }
}
