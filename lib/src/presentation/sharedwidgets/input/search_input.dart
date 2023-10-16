import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Icon? prefixIcon;
  final EdgeInsets? contentPadding;
  final double? elevation;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    this.controller,
    this.placeholder,
    this.hintStyle,
    this.fillColor,
    this.prefixIcon,
    this.contentPadding,
    this.elevation,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.bodyMedium,
        filled: true,
        fillColor: fillColor ?? Colors.white,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColorTheme.gray,
            width: elevation ?? 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColorTheme.gray,
            width: elevation ?? 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColorTheme.gray,
            width: elevation ?? 0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
