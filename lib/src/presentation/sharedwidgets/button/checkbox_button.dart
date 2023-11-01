import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckboxIcon extends StatefulWidget {
  final bool isClicked;
  final bool isDisabled; // Add this line
  final String iconPath;
  final String checkedIconPath;
  final Function(bool) onClicked;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle; // Add this line for disabled text style
  final String? title;

  const CheckboxIcon({
    Key? key,
    required this.isClicked,
    this.isDisabled = false, // Add this line
    required this.iconPath,
    required this.checkedIconPath,
    required this.onClicked,
    this.textStyle,
    this.disabledTextStyle, // Add this line
    this.title,
  }) : super(key: key);

  @override
  _CheckboxIconState createState() => _CheckboxIconState();
}

class _CheckboxIconState extends State<CheckboxIcon> {
  @override
  Widget build(BuildContext context) {
    // Disabled opacity
    const disabledOpacity = 0.4;

    return GestureDetector(
      onTap: widget.isDisabled
          ? null // Disable tap when the checkbox is disabled
          : () {
              setState(() {
                widget.onClicked(!widget.isClicked); // Toggle the clicked state
              });
            },
      child: Opacity(
        opacity: widget.isDisabled
            ? disabledOpacity
            : 1, // Apply opacity if disabled
        child: Row(
          children: [
            SvgPicture.asset(
              widget.isClicked ? widget.checkedIconPath : widget.iconPath,
              height: 20,
              width: 20,
              color: widget.isDisabled
                  ? Colors.grey
                  : null, // Apply color filter if disabled
            ),
            const SizedBox(width: 10), // Removed the .w for clarity
            Text(
              widget.title ?? '',
              style: widget.isDisabled
                  ? widget.disabledTextStyle ?? widget.textStyle
                  : widget.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
