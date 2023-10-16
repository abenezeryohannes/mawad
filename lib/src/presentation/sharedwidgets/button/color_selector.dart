import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/models/color_item.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class ColorSelector extends StatefulWidget {
  final List<ColorItem> colorItems;
  final ValueChanged<ColorItem> onColorSelected;
  late ColorItem selectedColor;

  ColorSelector(
      {super.key,
      required this.colorItems,
      required this.onColorSelected,
      required this.selectedColor});

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.selectedColor = widget.colorItems.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.colorItems.map((colorItem) {
        final color = colorItem.color;

        return GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedColor = colorItem;
              widget.onColorSelected(colorItem);
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 29.w,
                height: 29.h,
                margin: EdgeInsets.symmetric(
                    horizontal: 15.w), // Adjust the spacing as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              if (widget.selectedColor.id == colorItem.id)
                Container(
                  width: 37.w,
                  height: 37.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColorTheme.yellow,
                      width: 2.r,
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
