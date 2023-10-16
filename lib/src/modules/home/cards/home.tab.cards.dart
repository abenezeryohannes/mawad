import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SelectableCard extends StatefulWidget {
  const SelectableCard({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
    this.backgroundColor,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final Widget icon;
  final String label;
  final Color? backgroundColor;

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            width: 74.w,
            height: 74.h,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColorTheme.yellow
                  : widget.backgroundColor ?? AppColorTheme.lightGray,
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: widget.icon,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.label,
              style: AppTextTheme.brown14,
            ),
          )
        ],
      ),
    );
  }
}
