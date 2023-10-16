import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class ChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? labelColor;

  const ChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.backgroundColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? null : onPressed,
      child: Chip(
        backgroundColor: isSelected
            ? AppColorTheme.yellow
            : backgroundColor ?? Colors.transparent,
        side: BorderSide(
            color: isSelected
                ? AppColorTheme.yellow
                : backgroundColor ?? AppColorTheme.gray),
        label: Text(
          label,
          style: TextStyle(
              color:
                  isSelected ? Colors.black : labelColor ?? AppColorTheme.gray),
        ),
      ),
    );
  }
}
